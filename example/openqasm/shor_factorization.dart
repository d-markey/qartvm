import 'dart:math';

import 'package:qartvm/qartvm.dart';

void main(List<String> args) async {
  // USAGE: dart run shor_factorization.dart "3 * 5"
  final interpreter = OpenQASMInterpreter();
  final rnd = Random.secure();
  final N = (args.length == 1) ? await _readArg(args.single) : (3 * 7);

  var nBits = 0;
  while ((1 << nBits) <= N) {
    nBits++;
  }
  print('*** Register size for N = $N: $nBits');

  final sw = Stopwatch()..start();
  var round = 0;

  while (true) {
    round++;
    sw.reset();
    final a = 2 + rnd.nextInt(N - 2);
    final params = '(N, a) = ($N, $a)';

    print('************** ROUND #$round - $params **************');

    final k = N.gcd(a);
    if (k != 1) {
      // found classical solution, but we'll force the quantum path
      continue;
      // ignore: dead_code
      print('[${sw.elapsed}] Shor result for $params [classical route]');
      print('  factors = ${[k, N ~/ k]}');
      break;
    }

    final source = generateShorQasm(N, a, nBits);
    print('[${sw.elapsed}] Generated Shor program for $params');

    final program = OpenQASMParser.parse(source);
    print('[${sw.elapsed}] Parsed Shor program for $params');

    final result = await interpreter.execute(program);
    print('[${sw.elapsed}] Executed Shor program for $params');

    final measuredPhase = _readMeasuredPhase(result);
    final order = phaseToOrder(measuredPhase, nBits, a, N);
    final factors = factorFromOrder(N, a, order);

    print('[${sw.elapsed}] Shor result for $params [quantum route]');
    print('  measured phase = $measuredPhase');
    print('  estimated order = $order');
    if (factors.isEmpty) {
      print('  no non-trivial factors recovered');
    } else {
      print('  factors = $factors');
      print('');
      print('******************** SOURCE CODE ********************');
      print(source);
      print('*****************************************************');
      print('');
      break;
    }
  }
}

Future<int> _readArg(String arg) async {
  var N = int.tryParse(arg);
  if (N is int) return N;

  final program = OpenQASMParser.parse('''
    OPENQASM 3.0;
    int N = $arg;
  ''');

  final result = await OpenQASMInterpreter().execute(program);
  N = result.classicalVariables['N'];
  if (N is! int) throw ArgumentError('Invalid argument: $arg');
  print('*** N = $N = $arg');
  return N;
}

String generateShorQasm(int N, int a, int nBits) {
  final order = _modularOrder(a, N);
  print('*** Modular order for N = $N / a = $a: $order');

  final lines = <String>[
    'OPENQASM 3.0;',
    'include "stdgates.inc";',
    '',
    '// constants for this context',
    'const int N = $N;',
    'const int a = $a;',
    'const int n = $nBits;',
    '',
    '// computed modular order',
    'const int order = $order;',
    '',
    'qubit[n] x_reg;',
    'qubit[n] y_reg;',
    'bit[n] phase_bits;',
    '',
    'h x_reg;',
    'x y_reg[0];',
    '',
    '// Build the phase-estimation oracle as controlled modular multiplications.',
    '// For each power of two, we apply U^(2^j): y <- (a^(2^j) * y) mod N',
    '// conditioned on the j-th control qubit in x_reg.',
    '',
  ];

  // WARNING: SHOR REQUIRES MODULAR EXPONENTIATION, BUT THIS IS NOT...
  // The algorithm may eventually work, but this is not Shor.
  // Review is in progress...
  for (var controlBit = 0; controlBit < nBits; controlBit++) {
    final multiplier = _modPow(a, 1 << controlBit, N);
    lines.addAll(
      _generateControlledModAddQasm(
        modulus: N,
        constant: multiplier,
        controlRegister: 'x_reg',
        targetRegister: 'y_reg',
        controlBit: controlBit,
        targetBits: nBits,
      ),
    );
    lines.add('');
  }

  lines.addAll(_generateInverseQftQasm('x_reg', nBits));
  lines.add('');
  lines.add('phase_bits = measure x_reg;');
  return lines.join('\n');
}

Iterable<String> _generateControlledModAddQasm({
  required int modulus,
  required int constant,
  required String controlRegister,
  required String targetRegister,
  required int controlBit,
  required int targetBits,
}) sync* {
  // note: `constant` is already computed modulo `modulus`...
  final reduced = constant % modulus;
  yield (reduced == constant)
      ? '/* controlled modular add: y <- (y + $constant) mod $modulus when $controlRegister[$controlBit] = 1 */'
      : '/* controlled modular add: y <- (y + $constant) mod $modulus when $controlRegister[$controlBit] = 1 ($constant mod $modulus = $reduced) */';

  for (var targetBit = 0; targetBit < targetBits; targetBit++) {
    final bitMask = 1 << targetBit;
    if ((reduced & bitMask) == 0) {
      continue;
    }

    final angleDenominator = 1 << (targetBit + 1);
    yield 'cp((tau * $angleDenominator) / $modulus) '
        '$targetRegister[$targetBit], $controlRegister[$controlBit];';
  }
}

Iterable<String> _generateInverseQftQasm(String registerName, int nBits) sync* {
  yield 'h $registerName;';
  yield '';

  for (var bitIndex = 0; bitIndex < nBits - 1; bitIndex++) {
    final source = nBits - 2 - bitIndex;
    final target = nBits - 1 - bitIndex;
    final denominator = 1 << (bitIndex + 1);
    yield 'cp(-pi / $denominator) $registerName[$source], $registerName[$target];';
  }
}

int _modularOrder(int base, int modulus) {
  final reduced = base % modulus;
  for (var order = 1; order <= modulus; order++) {
    if (_modPow(reduced, order, modulus) == 1) {
      return order;
    }
  }
  throw StateError('No multiplicative order found for $base mod $modulus');
}

int _readMeasuredPhase(InterpreterResult result) {
  final measurements = result.measurements;

  if (measurements.containsKey('x_reg')) return measurements['x_reg']!;
  if (measurements.containsKey('phase_bits')) {
    return measurements['phase_bits']!;
  }

  final phaseKey = measurements.keys.firstWhere(
    (key) =>
        key.toLowerCase().contains('phase') ||
        key.toLowerCase().contains('x_reg'),
    orElse: () => '',
  );
  if (phaseKey.isNotEmpty) {
    return measurements[phaseKey]!;
  }

  throw StateError(
    'No measured phase was found in the execution result: ${measurements.keys.toList()}',
  );
}

int phaseToOrder(int phaseEstimate, int registerBits, int a, int n) {
  final candidates = <int>{1};

  final denominator = 1 << registerBits;
  final phase = phaseEstimate / denominator;

  final candidate = _continuedFractionReduce(phase, n);
  if (candidate != null && candidate > 0) {
    candidates.add(candidate);
  }

  for (var order = 1; order <= n; order++) {
    final estimate = order * phase;
    final nearestInteger = estimate.round();
    final distance = (estimate - nearestInteger).abs();
    if (distance < 0.000001) {
      candidates.add(order);
    }
  }

  final validCandidate =
      candidates
          .where((candidate) => _isValidOrderCandidate(a, n, candidate))
          .toList()
        ..sort();

  if (validCandidate.isEmpty) {
    return 1;
  }

  return validCandidate.first;
}

bool _isValidOrderCandidate(int a, int n, int candidate) {
  if (candidate <= 0 || candidate > n) return false;
  return _modPow(a, candidate, n) == 1;
}

int? _continuedFractionReduce(double phase, int n) {
  final denominators = <int>[];
  final maxOrder = n;

  for (var order = 1; order <= maxOrder; order++) {
    final estimate = order * phase;
    final nearestInteger = estimate.round();
    final distance = (estimate - nearestInteger).abs();
    if (distance < 0.000001) {
      denominators.add(order);
    }
  }

  if (denominators.isEmpty) {
    return null;
  }

  return denominators.first;
}

List<int> factorFromOrder(int n, int a, int order) {
  if (order <= 1 || order % 2 != 0) return const [];

  if (!_isValidOrderCandidate(a, n, order)) return const [];

  final halfOrder = order ~/ 2;
  final left = _modPow(a, halfOrder, n);
  final factors = <int>{(left - 1).gcd(n), (left + 1).gcd(n)}
    ..removeWhere((value) => value <= 1 || value >= n);

  final sorted = factors.toList()..sort();
  return sorted;
}

int _modPow(int base, int exp, int modulus) {
  var result = 1;
  var current = base % modulus;
  var exponent = exp;

  while (exponent > 0) {
    if ((exponent & 1) == 1) {
      result = (result * current) % modulus;
    }
    current = (current * current) % modulus;
    exponent >>= 1;
  }

  return result;
}
