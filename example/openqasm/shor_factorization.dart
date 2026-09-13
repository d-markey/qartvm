import 'dart:io';
import 'dart:math';

import 'package:qartvm/qartvm.dart';

import 'shor_generator.dart';

final rnd = Random.secure(), sw = Stopwatch()..start();

void main(List<String> args) async {
  // USAGE: dart run shor_factorization.dart "3 * 5" [--type synthesis|ripple|qft]

  if (args.isEmpty) {
    print(
      'Usage: dart run shor_factorization.dart <N> [--type synthesis|ripple|qft]',
    );
    return;
  }

  final N = await _readArg(args[0]);

  String type = 'synthesis';
  for (int i = 1; i < args.length; i++) {
    if (args[i] == '--type' && i + 1 < args.length) {
      type = args[++i];
    }
  }

  // Generator factory
  ShorQasmGenerator createGenerator(int n, int a) {
    return switch (type) {
      'ripple' => RippleCarryAdderShorQasmGenerator(n, a),
      'qft' => QftAdderShorQasmGenerator(n, a),
      _ => ShorQasmGenerator(n, a),
    };
  }

  // Pre-calculate nx from a sample generator
  final sampleGen = createGenerator(N, N - 1);
  final nx = sampleGen.nx;

  print(
    '[${sw.elapsed}] *** Factorization of N = $N using $type generator\n'
    '[${sw.elapsed}] *** Circuit size = ${sampleGen.circuitSize} qubits\n'
    '[${sw.elapsed}] ***    nx: ${sampleGen.nx}\n'
    '[${sw.elapsed}] ***    ny: ${sampleGen.ny}\n'
    '[${sw.elapsed}] ***    nanc: ${sampleGen.nAncilla}',
  );
  final xmask = Iterable.generate(
    sampleGen.circuitSize,
    (i) => i < sampleGen.nx ? '*' : '.',
  ).join();

  var curStep = 0, maxSteps = 0;
  final interpreter = OpenQASMInterpreter()
    ..addObserver((idx, stmt, state) {
      if (idx == 0) {
        curStep = 0;
        stdout.writeln();
      }
      if (_isMeasurement(stmt)) {
        curStep++;
        stdout.writeln();
        stdout.writeln('[${sw.elapsed}] Measurement at curStep = $curStep');
        stdout.writeln(
          '[${sw.elapsed}] Mask: $xmask (len=${xmask.length}), State size: ${state.size}',
        );
        final outcomes = state.getProbabilities(xmask).entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        for (var entry in outcomes) {
          if (entry.value < 1e-5) continue;
          final key = entry.key.substring(0, nx);
          final phase = (key == '')
              ? null
              : int.tryParse(
                  String.fromCharCodes(key.codeUnits.toList().reversed),
                  radix: 2,
                );
          print(
            '[${sw.elapsed}]    > $key ($phase): ${(entry.value * 100).toStringAsFixed(2)} %',
          );
        }
      } else if (stmt is GateCallStatement) {
        curStep++;
        stdout.write('.');
      }
    });

  // prepare generators
  final generators = <({int a, ShorQasmGenerator gen})>[];
  for (var a = 2; a < N - 1; a++) {
    if (N.gcd(a) != 1) continue;
    generators.add((a: a, gen: createGenerator(N, a)));
  }

  generators
    ..shuffle()
    ..sort(
      (a, b) =>
          a.gen.estimateComplexity().compareTo(b.gen.estimateComplexity()),
    );

  print(
    '[${sw.elapsed}] *** Complexities:'
    ' min ${generators.first.gen.estimateComplexity()},'
    ' max ${generators.last.gen.estimateComplexity()},'
    ' total ${generators.length}',
  );

  var round = 0;

  while (true) {
    if (round >= generators.length) {
      print('FAILED');
      break;
    }

    final entry = generators[round];
    final a = entry.a;
    final params = '(N, a) = ($N, $a)';
    round++;
    sw.reset();

    print(
      '[${sw.elapsed}] ************** ROUND #$round - $params **************',
    );

    maxSteps = entry.gen.estimateComplexity();
    print('[${sw.elapsed}] Shor estimated complexity for $params: $maxSteps');

    final source = entry.gen.generate();
    print('[${sw.elapsed}] Generated Shor program for $params');

    final program = OpenQASMParser.parse(source);
    print('[${sw.elapsed}] Parsed Shor program for $params');

    var attempts = 0, done = false;
    while (attempts < 3 && !done) {
      attempts++;
      print('[${sw.elapsed}] ----- ATTEMPT #$attempts -----');
      // Optimization: use cache for all types since matrices are local
      final results = await interpreter.execute(program, withCache: true);
      print('[${sw.elapsed}] Executed Shor program for $params');

      final result = results[0];
      final measuredPhase = _readMeasuredPhase(result);
      final order = _phaseToOrder(measuredPhase, nx, a, N);
      final factors = _factorFromOrder(N, a, order);

      print('[${sw.elapsed}] Shor result for $params [quantum route]');
      if (factors.isEmpty) {
        print(
          '  measured phase = $measuredPhase\n'
          '  estimated order = $order\n'
          '  no non-trivial factors recovered',
        );
        // If we found a valid order but it's useless for factoring,
        // no point in doing 10 attempts for this 'a'.
        if (order > 1 && _isValidOrderCandidate(a, N, order)) {
          print('  (a=$a is likely a dead end, moving to next round)');
          break;
        }
      } else {
        done = true;
        final res = factors.reduce((a, b) => a * b);
        print(
          '  measured phase = $measuredPhase --> estimated order = $order\n'
          '  factors = $factors --> product = $res\n'
          '  ${res == N ? 'PASS' : 'FAIL -- expected $N'}',
        );
        break;
      }
    }
    if (done) break;
  }
}

Future<int> _readArg(String arg) async {
  var N = int.tryParse(arg);
  if (N == null) {
    final program = OpenQASMParser.parse('OPENQASM 3.0;\nint N = $arg;');
    final result = (await OpenQASMInterpreter().execute(program))[0];
    N = result.classicalVariables['N'];
    if (N is! int) throw ArgumentError('Invalid argument: $arg');
    print('[${sw.elapsed}] *** N = $arg = $N');
  } else {
    print('[${sw.elapsed}] *** N = $N');
  }
  return N;
}

bool _isMeasurement(Statement stmt) {
  if (stmt is MeasurementStatement) return true;
  if (stmt is AssignmentStatement && stmt.value is MeasureExpression) {
    return true;
  }
  if (stmt is ClassicalDeclaration && stmt.initializer is MeasureExpression) {
    return true;
  }
  return false;
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

int _phaseToOrder(int phaseEstimate, int registerBits, int a, int n) {
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

List<int> _factorFromOrder(int n, int a, int order) {
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
