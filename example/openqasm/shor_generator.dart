/// Calculates the bit length required to represent an integer.
int bitLength(int n) => n <= 0 ? 0 : n.bitLength;

/// Computes (base^exp) % mod via modular exponentiation
int powerMod(int base, int exp, int mod) {
  int res = 1;
  int b = base % mod;
  int e = exp;
  while (e > 0) {
    if (e % 2 == 1) res = (res * b) % mod;
    b = (b * b) % mod;
    e ~/= 2;
  }
  return res;
}

class ShorQasmGenerator {
  final int N;
  final int a;

  ShorQasmGenerator(this.N, this.a) {
    // Using Dart's native int.gcd() method
    if (a.gcd(N) != 1) {
      throw ArgumentError(
        'gcd(a, N) must be 1. $a and $N share factor: ${a.gcd(N)}',
      );
    }
    ny = bitLength(N);
    // nx = 2 * ny is the theoretical requirement for large N.
    // For small N in a simulator, we can use ny + 1 or ny + 2 to save time.
    if (N <= 15) {
      nx = 4;
    } else if (N <= 31) {
      nx = 6;
    } else {
      nx = 2 * ny;
    }

    // A single transposition gate can need up to `ny` simultaneous controls
    // (1 control qubit + up to ny-1 other target-register bits). A k-input
    // multi-controlled-X built from only cx/ccx needs (k - 2) ancilla
    // qubits once k > 2.
    nAncilla = ny > 2 ? ny - 2 : 0;
  }

  late int ny;
  late int nx;
  late int nAncilla;

  int get circuitSize => ny + nx + nAncilla;

  // ---------------------------------------------------------------------
  // Multi-controlled-X (target ^= AND of all controls), using only cx/ccx.
  // ---------------------------------------------------------------------
  //
  // - 1 control  -> plain cx
  // - 2 controls -> plain ccx (Toffoli)
  // - 3+ controls -> an AND-ladder that borrows `ancilla` qubits to compute
  //   the conjunction of the first (k-1) controls into a chain of ancilla,
  //   applies the final AND directly onto the target via the last control,
  //   then uncomputes the ladder so every ancilla qubit is returned to |0>
  //   (safe to reuse immediately afterwards).
  Iterable<String> _mcx(
    List<String> controls,
    String target,
    List<String> ancilla,
  ) sync* {
    final k = controls.length;
    switch (k) {
      case 0:
        throw ArgumentError('_mcx requires at least one control');

      case 1:
        yield 'cx ${controls[0]}, $target;';
      case 2:
        yield 'ccx ${controls[0]}, ${controls[1]}, $target;';

      default:
        final need = k - 2;
        if (ancilla.length < need) {
          throw StateError(
            'Not enough ancilla qubits for a $k-control gate: '
            'need $need, have ${ancilla.length}',
          );
        }

        // Compute AND(controls[0..k-2]) into ancilla[need - 1].
        yield 'ccx ${controls[0]}, ${controls[1]}, ${ancilla[0]};';
        for (var i = 2; i < k - 1; i++) {
          yield 'ccx ${ancilla[i - 2]}, ${controls[i]}, ${ancilla[i - 1]};';
        }

        // Combine the last ancilla with the final control directly onto target.
        yield 'ccx ${ancilla[need - 1]}, ${controls[k - 1]}, $target;';

        // Uncompute the ladder so ancilla qubits are restored to |0>.
        for (var i = k - 2; i >= 2; i--) {
          yield 'ccx ${ancilla[i - 2]}, ${controls[i]}, ${ancilla[i - 1]};';
        }
        yield 'ccx ${controls[0]}, ${controls[1]}, ${ancilla[0]};';
    }
  }

  // ---------------------------------------------------------------------
  // A TRUE transposition: swap exactly the two y-register values A and B
  // (as `numBits`-bit patterns), identity on every other basis state,
  // controlled by `ctrlQubit`.
  // ---------------------------------------------------------------------
  //
  // WHY THIS IS NEEDED (and why a naive bit-flip approach is NOT enough):
  //
  // The natural first idea is: flip every bit where A and B differ,
  // controlled on the bits where A and B agree. That is only safe to do
  // in one shot when A and B differ in exactly one bit -- because then the
  // "agreement pattern" uniquely picks out {A, B} and nothing else. As
  // soon as A and B differ in two or more bits, that same agreement
  // pattern is shared by every value obtained by flipping any subset of
  // the differing bits (a whole "coset" of 2^popcount(diff) values, not
  // just A and B), so naively flipping all differing bits under that
  // control also scrambles those other values -- which is wrong unless
  // the target permutation happens to want the same XOR applied
  // uniformly across that whole coset (it generally doesn't).
  //
  // The fix: pick one differing bit `p` as a pivot, and fold every OTHER
  // differing bit `bj` onto it via `cx y[p], y[bj]` (bj ^= p). Because A
  // and B differ at both p and bj, this fold makes bit bj IDENTICAL
  // between (transformed) A and (transformed) B -- so after folding all
  // extra differing bits away, A and B differ in only the pivot bit p.
  // A weight-1 difference is always collision-free (only 2 states share
  // that agreement pattern), so a single full-width multi-controlled-X
  // flipping bit p, controlled on ctrlQubit plus every other bit matching
  // the (now-shared) agreement pattern, is guaranteed to touch only this
  // exact pair. Folding back (re-applying the same CNOTs, which are
  // self-inverse) restores the original encoding everywhere else.
  Iterable<String> _trueTransposition(
    String ctrlQubit,
    int numBits,
    int stateA,
    int stateB,
    List<String> ancilla,
  ) sync* {
    final diff = stateA ^ stateB;
    if (diff == 0) return;

    final diffBits = [
      for (int b = 0; b < numBits; b++)
        if ((diff & (1 << b)) != 0) b,
    ];
    final p = diffBits.first;
    final otherDiff = diffBits.sublist(1);

    // Fold every other differing bit onto the pivot.
    for (final bj in otherDiff) {
      yield 'cx y_reg[$p], y_reg[$bj];';
    }

    // Determine the (post-fold) shared pattern of stateA on every bit
    // except p, to build the full-width control for flipping bit p.
    final aP = (stateA >> p) & 1;
    final pos = [ctrlQubit];
    final neg = <String>[];
    for (var c = 0; c < numBits; c++) {
      if (c == p) continue;
      final val = otherDiff.contains(c)
          ? (((stateA >> c) & 1) ^ aP) // post-fold shared value
          : ((stateA >> c) & 1); // untouched "same" bit
      if (val == 1) {
        pos.add('y_reg[$c]');
      } else {
        neg.add('y_reg[$c]');
      }
    }

    for (final nc in neg) {
      yield 'x $nc;';
    }
    yield* _mcx([...pos, ...neg], 'y_reg[$p]', ancilla);
    for (final nc in neg) {
      yield 'x $nc;';
    }

    // Undo the fold (self-inverse).
    for (final bj in otherDiff.reversed) {
      yield 'cx y_reg[$p], y_reg[$bj];';
    }
  }

  /// Synthesizes modular multiplier using pure stdgates.inc primitives (cx, ccx)
  Iterable<String> synthesizeControlledModularMultiplier(
    int multiplier,
    String ctrlQubit,
    int numTargetBits,
  ) sync* {
    final maxState = 1 << numTargetBits;

    // 1. Permutation lookup table for range [0, N-1]
    final perm = <int, int>{};
    for (var y = 0; y < maxState; y++) {
      perm[y] = (y < N) ? (y * multiplier) % N : y;
    }

    // 2. Synthesize state transpositions
    final currentState = List<int>.generate(maxState, (i) => i);
    final ancilla = List<String>.generate(nAncilla, (i) => 'anc[$i]');

    for (var i = 0; i < maxState; i++) {
      final targetVal = perm[i]!;
      if (currentState[i] == targetVal) continue;

      final loc = currentState.indexOf(targetVal);
      yield* _trueTransposition(
        ctrlQubit,
        numTargetBits,
        currentState[i],
        targetVal,
        ancilla,
      );

      final temp = currentState[i];
      currentState[i] = currentState[loc];
      currentState[loc] = temp;
    }
  }

  String generate() => [
    'OPENQASM 3.0;',
    'include "stdgates.inc";',
    '',
    ..._generate(),
  ].join('\n');

  Iterable<String> _generate() sync* {
    yield '// Shor\'s Algorithm OpenQASM 3.0';
    yield '// Target N = $N, Base a = $a';
    yield '// Control Register (x): $nx qubits';
    yield '// Target Register (y): $ny qubits';
    if (nAncilla > 0) {
      yield '// Ancilla Register (scratch for multi-controlled gates): $nAncilla qubits';
    }
    yield '';

    yield '// Register Declarations';
    yield 'qubit[$nx] x_reg;';
    yield 'qubit[$ny] y_reg;';
    if (nAncilla > 0) {
      yield 'qubit[$nAncilla] anc;';
    }
    yield 'bit[$nx] phase_bits;';
    yield '';

    yield '// --- Step 1: Initialization ---';
    yield 'h x_reg;';
    yield 'x y_reg[0]; // Initialize y to |1>';
    yield '';

    yield '// --- Step 2: Controller Modular Exponentiation ---';
    for (var j = 0; j < nx; j++) {
      final power = powerMod(a, 1 << j, N);
      yield '// Control qubit x_reg[$j]: y -> ($power * y) mod $N';
      if (power == 1) {
        yield '// Power is 1 mod $N (Identity operation)';
      } else {
        yield* synthesizeControlledModularMultiplier(power, 'x_reg[$j]', ny);
      }
      yield '';
    }

    yield '// --- Step 3: Inverse QFT (QFT†) ---';
    for (var i = nx - 1; i >= 0; i--) {
      for (var j = nx - 1; j > i; j--) {
        final denom = (1 << (j - i + 1));
        yield 'cp(-tau / $denom) x_reg[$j], x_reg[$i];';
      }
      yield 'h x_reg[$i];';
    }
    yield '';

    yield '// SWAP network for qubit reordering';
    final n = nx ~/ 2;
    for (var i = 0; i < n; i++) {
      yield 'swap x_reg[$i], x_reg[${nx - 1 - i}];';
    }
    yield '';

    yield '// --- Step 4: Measurement ---';
    yield 'phase_bits = measure x_reg;';
  }

  int estimateComplexity() => _generate().where((l) => !_ignore(l)).length;
}

/// Shor algorithm generator using Ripple-Carry Arithmetic (MAJ/UMA gates).
/// This implementation builds the circuit from the Cuccaro adder logic.
class RippleCarryAdderShorQasmGenerator extends ShorQasmGenerator {
  RippleCarryAdderShorQasmGenerator(super.N, super.a) {
    // Logic requires more ancilla qubits for modular arithmetic
    // - ny+1 for the accumulator/sum register
    // - ny for the constant register
    // - 3 for flag, carry and aux qubits
    nAncilla = 2 * ny + 4;
  }

  @override
  Iterable<String> _generate() sync* {
    yield '// Logic-based Shor\'s Algorithm';
    yield '// Target N = $N, Base a = $a';
    yield '// Total Qubits: $circuitSize ($nx control, $ny target, $nAncilla logic-ancilla)';
    yield '';

    yield '// Subroutines for Arithmetic';
    yield 'gate maj cin, a, b {';
    yield '  cx b, a;';
    yield '  cx b, cin;';
    yield '  ccx a, cin, b;';
    yield '}';
    yield '';
    yield 'gate uma cin, a, b {';
    yield '  ccx a, cin, b;';
    yield '  cx b, cin;';
    yield '  cx cin, a;';
    yield '}';
    yield '';
    yield 'gate maj_dg cin, a, b {';
    yield '  ccx a, cin, b;';
    yield '  cx b, cin;';
    yield '  cx b, a;';
    yield '}';
    yield '';
    yield 'gate uma_dg cin, a, b {';
    yield '  cx cin, a;';
    yield '  cx b, cin;';
    yield '  ccx a, cin, b;';
    yield '}';
    yield '';

    yield '// Register Declarations';
    yield 'qubit[$nx] x_reg;';
    yield 'qubit[$ny] y_reg;';
    yield 'qubit[${ny + 1}] sum_reg;';
    yield 'qubit[$ny] const_reg;';
    yield 'qubit aux;';
    yield 'qubit carry;';
    yield 'qubit flag;';
    yield 'bit[$nx] phase_bits;';
    yield '';

    yield '// --- Step 1: Initialization ---';
    yield 'h x_reg;';
    yield 'x y_reg[0]; // Start at y=1';
    yield '';

    yield '// --- Step 2: Modular Exponentiation ---';
    for (var j = 0; j < nx; j++) {
      final power = powerMod(a, 1 << j, N);
      yield '// Controlled multiplier: y -> ($power * y) mod $N';
      if (power == 1) {
        yield '// Power is 1 mod $N (Identity operation)';
      } else {
        yield* _controlledModularMul(power, 'x_reg[$j]');
      }
    }

    yield '// --- Step 3: Inverse QFT ---';
    for (int i = nx - 1; i >= 0; i--) {
      for (int j = nx - 1; j > i; j--) {
        final denom = (1 << (j - i + 1));
        yield 'cp(-tau / $denom) x_reg[$j], x_reg[$i];';
      }
      yield 'h x_reg[$i];';
    }

    // SWAP network
    final n = nx ~/ 2;
    for (var i = 0; i < n; i++) {
      yield 'swap x_reg[$i], x_reg[${nx - 1 - i}];';
    }

    yield '// --- Step 4: Measurement ---';
    yield 'phase_bits = measure x_reg;';
  }

  /// Appends logic for y -> (multiplier * y) mod N
  Iterable<String> _controlledModularMul(int multiplier, String ctrl) sync* {
    // y -> a*y mod N is implemented as:
    // 1. For each bit i of y:
    //    If y[i]==1, add (multiplier * 2^i mod N) to sum_reg (controlled by ctrl)
    // 2. Swap y and sum_reg
    // 3. Uncompute to clear sum_reg

    // Note: To keep the QASM output manageable for the simulator,
    // we generate inline arithmetic blocks.
    for (var i = 0; i < ny; i++) {
      final constant = (multiplier * (1 << i)) % N;
      if (constant == 0) continue;

      yield '//   Add $constant to sum if y_reg[$i] is set';
      yield* _controlledModularAdd(constant, ctrl, 'y_reg[$i]');
    }

    // Swap and Uncompute (Simplified for small N simulation)
    for (var i = 0; i < ny; i++) {
      yield 'cswap $ctrl, y_reg[$i], sum_reg[$i];';
    }

    // Modular Inverse for uncomputation
    final inv = _modularInverse(multiplier, N);
    for (var i = 0; i < ny; i++) {
      final constant = (inv * (1 << i)) % N;
      if (constant == 0) continue;
      yield* _controlledModularAdd(constant, ctrl, 'y_reg[$i]', inverse: true);
    }
  }

  Iterable<String> _controlledModularAdd(
    int C,
    String ctrl1,
    String ctrl2, {
    bool inverse = false,
  }) sync* {
    if (!inverse) {
      yield '// Logic: sum = (sum + $C) mod $N';
      yield '// 1. Add C';
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg');
      yield '// 2. Compare with N (subtract N)';
      yield* _constantAdd(N, [], 'sum_reg', subtract: true);
      yield '// 3. Use carry out to decide if we add N back';
      yield '// If sum < N, the carry out (sum_reg[ny]) will be 0.';
      yield 'x sum_reg[$ny];';
      yield 'cx sum_reg[$ny], aux;';
      yield 'x sum_reg[$ny];';
      yield* _constantAdd(N, ['aux'], 'sum_reg');
      yield '// 4. Cleanup carry (Reset aux to 0)';
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg', subtract: true);
      yield 'cx sum_reg[$ny], aux;';
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg');
    } else {
      // Modular Subtraction (Inverse of Modular Addition)
      // 1. Undoing Step 4 (Cleanup)
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg', subtract: true);
      yield 'x sum_reg[$ny];';
      yield 'ccx $ctrl1, $ctrl2, sum_reg[$ny];';
      yield 'x sum_reg[$ny];';
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg');

      // 2. Undoing Step 3 (Add N back)
      yield* _constantAdd(N, ['aux'], 'sum_reg', subtract: true);
      yield 'x sum_reg[$ny];';
      yield 'cx sum_reg[$ny], aux;';
      yield 'x sum_reg[$ny];';

      // 3. Undoing Step 2 (Subtract N)
      yield* _constantAdd(N, [], 'sum_reg');

      // 4. Undoing Step 1 (Add C)
      yield* _constantAdd(C, [ctrl1, ctrl2], 'sum_reg', subtract: true);
    }
  }

  Iterable<String> _constantAdd(
    int C,
    List<String> controls,
    String targetReg, {
    bool subtract = false,
  }) sync* {
    yield '// 1. Set constant in const_reg (controlled)';
    for (var i = 0; i < ny; i++) {
      if ((C >> i) & 1 == 1) {
        yield switch (controls.length) {
          0 => 'x const_reg[$i];',
          1 => 'cx ${controls[0]}, const_reg[$i];',
          _ => 'ccx ${controls[0]}, ${controls[1]}, const_reg[$i];',
        };
      }
    }

    yield '// 2. Ripple Carry Add';
    yield* _rippleCarryAdd('const_reg', targetReg, ny, inverse: subtract);

    yield '// 3. Uncompute constant';
    for (var i = 0; i < ny; i++) {
      if ((C >> i) & 1 == 1) {
        yield switch (controls.length) {
          0 => 'x const_reg[$i];',
          1 => 'cx ${controls[0]}, const_reg[$i];',
          _ => 'ccx ${controls[0]}, ${controls[1]}, const_reg[$i];',
        };
      }
    }
  }

  Iterable<String> _rippleCarryAdd(
    String regA,
    String regB,
    int n, {
    bool inverse = false,
  }) sync* {
    if (!inverse) {
      yield 'maj carry, $regB[0], $regA[0];';
      for (var i = 1; i < n; i++) {
        yield 'maj $regA[${i - 1}], $regB[$i], $regA[$i];';
      }
      yield 'cx $regA[${n - 1}], $regB[$n];';
      for (var i = n - 1; i >= 1; i--) {
        yield 'uma $regA[${i - 1}], $regB[$i], $regA[$i];';
      }
      yield 'uma carry, $regB[0], $regA[0];';
    } else {
      // Subtraction: Adjoint of the forward pass
      yield 'uma_dg carry, $regB[0], $regA[0];';
      for (var i = 1; i < n; i++) {
        yield 'uma_dg $regA[${i - 1}], $regB[$i], $regA[$i];';
      }
      yield 'cx $regA[${n - 1}], $regB[$n];';
      for (var i = n - 1; i >= 1; i--) {
        yield 'maj_dg $regA[${i - 1}], $regB[$i], $regA[$i];';
      }
      yield 'maj_dg carry, $regB[0], $regA[0];';
    }
  }

  int _modularInverse(int n, int mod) {
    for (int x = 1; x < mod; x++) {
      if ((n * x) % mod == 1) return x;
    }
    return 1;
  }
}

/// Shor algorithm generator using QFT-based Arithmetic (Draper Adder).
/// This is generally more efficient in terms of qubit count than the
/// ripple-carry version as it performs addition directly in the Fourier basis.
class QftAdderShorQasmGenerator extends ShorQasmGenerator {
  QftAdderShorQasmGenerator(super.N, super.a) {
    // QFT logic with accumulator:
    // - ny qubits for y_reg
    // - ny+1 for sum_reg
    // - 1 for carry aux
    nAncilla = ny + 2;
  }

  @override
  Iterable<String> _generate() sync* {
    yield '// QFT-based Shor\'s Algorithm (Accumulator method)';
    yield '// Target N = $N, Base a = $a';
    yield '// Total Qubits: $circuitSize';
    yield '';

    yield '// Register Declarations';
    yield 'qubit[$nx] x_reg;';
    yield 'qubit[$ny] y_reg;';
    yield 'qubit[${ny + 1}] sum_reg;';
    yield 'qubit aux;';
    yield 'bit[$nx] phase_bits;';
    yield '';

    yield '// --- Step 1: Initialization ---';
    yield 'h x_reg;';
    yield 'x y_reg[0];';
    yield '';

    yield '// --- Step 2: Controlled Modular Exponentiation ---';
    for (var i = 0; i < nx; i++) {
      final power = powerMod(a, 1 << i, N);
      yield '// Controlled modular multiplier: y -> ($power * y) mod $N';
      if (power == 1) {
        yield '// Power is 1 mod $N (Identity operation)';
      } else {
        yield* _controlledModularMul(power, 'x_reg[$i]');
      }
      yield '';
    }

    yield '// --- Step 3: Inverse QFT ---';
    for (var i = nx - 1; i >= 0; i--) {
      for (var j = nx - 1; j > i; j--) {
        final denom = (1 << (j - i + 1));
        yield 'cp(-tau / $denom) x_reg[$j], x_reg[$i];';
      }
      yield 'h x_reg[$i];';
    }
    yield '';

    yield '// SWAP network';
    final n = nx / 2;
    for (var i = 0; i < n; i++) {
      yield 'swap x_reg[$i], x_reg[${nx - 1 - i}];';
    }
    yield '';

    yield '// --- Step 4: Measurement ---';
    yield 'phase_bits = measure x_reg;';
  }

  Iterable<String> _controlledModularMul(int multiplier, String ctrl) sync* {
    yield '// QFT accumulator';
    yield* _qft('sum_reg', ny + 1);

    for (var i = 0; i < ny; i++) {
      final constant = (multiplier * (1 << i)) % N;
      if (constant == 0) continue;
      yield* _fourierModularAdd(constant, [ctrl, 'y_reg[$i]'], 'sum_reg');
    }

    yield '// IQFT accumulator';
    yield* _inverseQft('sum_reg', ny + 1);

    // Swap registers
    for (var i = 0; i < ny; i++) {
      yield 'cswap $ctrl, y_reg[$i], sum_reg[$i];';
    }

    // Uncompute to clear sum_reg
    final inv = _modularInverse(multiplier, N);
    yield '// Uncompute using inverse $inv';
    yield* _qft('sum_reg', ny + 1);
    for (var i = 0; i < ny; i++) {
      final constant = (inv * (1 << i)) % N;
      if (constant == 0) continue;
      yield* _fourierModularAdd(
        constant,
        [ctrl, 'y_reg[$i]'],
        'sum_reg',
        inverse: true,
      );
    }
    yield* _inverseQft('sum_reg', ny + 1);
  }

  Iterable<String> _fourierModularAdd(
    int C,
    List<String> controls,
    String targetReg, {
    bool inverse = false,
  }) sync* {
    if (!inverse) {
      yield* _fourierConstantAdd(C, controls, targetReg);
      yield* _fourierConstantAdd(N, [], targetReg, subtract: true);
      yield* _inverseQft(targetReg, ny + 1);
      yield 'cx $targetReg[$ny], aux;';
      yield* _qft(targetReg, ny + 1);
      yield* _fourierConstantAdd(N, ['aux'], targetReg);
      yield* _fourierConstantAdd(C, controls, targetReg, subtract: true);
      yield* _inverseQft(targetReg, ny + 1);
      yield 'x $targetReg[$ny];';
      yield 'cx $targetReg[$ny], aux;';
      yield 'x $targetReg[$ny];';
      yield* _qft(targetReg, ny + 1);
      yield* _fourierConstantAdd(C, controls, targetReg);
    } else {
      // Full mirror for uncomputation (Adjoint of forward pass)
      yield* _fourierConstantAdd(C, controls, targetReg, subtract: true);
      yield* _inverseQft(targetReg, ny + 1);
      yield 'x $targetReg[$ny];';
      yield 'cx $targetReg[$ny], aux;';
      yield 'x $targetReg[$ny];';
      yield* _qft(targetReg, ny + 1);
      yield* _fourierConstantAdd(C, controls, targetReg);
      yield* _fourierConstantAdd(N, ['aux'], targetReg, subtract: true);
      yield* _inverseQft(targetReg, ny + 1);
      yield 'cx $targetReg[$ny], aux;';
      yield* _qft(targetReg, ny + 1);
      yield* _fourierConstantAdd(N, [], targetReg);
      yield* _fourierConstantAdd(C, controls, targetReg, subtract: true);
    }
  }

  Iterable<String> _fourierConstantAdd(
    int C,
    List<String> controls,
    String reg, {
    bool subtract = false,
  }) sync* {
    final n = ny + 1;
    for (var i = 0; i < n; i++) {
      var angle = 0.0;
      for (int j = 0; j <= i; j++) {
        if ((C >> j) & 1 == 1) {
          angle += 1.0 / (1 << (i - j + 1));
        }
      }
      if (angle == 0) continue;
      if (subtract) angle = -angle;

      switch (controls.length) {
        case 0:
          yield 'p(tau * $angle) $reg[$i];';
        case 1:
          yield 'cp(tau * $angle) ${controls[0]}, $reg[$i];';
        default:
          // Multi-control phase
          yield '// CC-Phase (tau * $angle)';
          yield 'cp(tau * ${angle / 2}) ${controls[0]}, $reg[$i];';
          yield 'cx ${controls[0]}, ${controls[1]};';
          yield 'cp(-tau * ${angle / 2}) ${controls[1]}, $reg[$i];';
          yield 'cx ${controls[0]}, ${controls[1]};';
          yield 'cp(tau * ${angle / 2}) ${controls[1]}, $reg[$i];';
      }
    }
  }

  Iterable<String> _qft(String reg, int n) sync* {
    for (var i = n - 1; i >= 0; i--) {
      yield 'h $reg[$i];';
      for (var j = i - 1; j >= 0; j--) {
        final denom = (1 << (i - j + 1));
        yield 'cp(tau / $denom) $reg[$i], $reg[$j];';
      }
    }
  }

  Iterable<String> _inverseQft(String reg, int n) sync* {
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < i; j++) {
        final denom = (1 << (i - j + 1));
        yield 'cp(-tau / $denom) $reg[$i], $reg[$j];';
      }
      yield 'h $reg[$i];';
    }
  }

  int _modularInverse(int n, int mod) {
    for (var x = 1; x < mod; x++) {
      if ((n * x) % mod == 1) return x;
    }
    return 1;
  }
}

bool _ignore(String line) {
  line = line.trim();
  return line.isEmpty || line.startsWith('//');
}
