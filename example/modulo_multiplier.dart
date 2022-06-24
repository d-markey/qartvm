import 'package:qartvm/qartvm.dart';
import 'package:squadron/squadron.dart';

import 'shor/shor_builders.dart';
import 'utils.dart';

QGateType adder = QGateType('add [x]', '+[x]');
QGateType subtractor = QGateType('sub [x]', '-[x]');
QGateType moduloAdder = QGateType('add [x] modulo [N]', '+[x] % [N]');
QGateType flagSetter = QGateType('check overflow', 'set');
QGateType flagResetter = QGateType('reset overflow', 'reset');
QGateType swapper = QGateType('swap registers [a] and [b]', 'r-swap');

Future<QCircuit> _buildAddGate(ShorBuilders shorBuilders, int constant,
    QRegister qreg, QGateBuilder builder) async {
  final gate = await shorBuilders.addGate(qreg.qubits, constant);
  final component = QCircuit(builder);
  component.custom(qreg, gate, type: adder, params: {'x': constant});
  return component;
}

Future<QCircuit> _buildFlagSetterGate(ShorBuilders shorBuilders, QRegister qreg,
    QRegister qflag, QGateBuilder builder) async {
  final gate = await shorBuilders.setFlagOnOverflowGate(qreg.qubits, qflag[0]);
  final component = QCircuit(builder);
  component.custom([...qreg.qubits, ...qflag.qubits], gate, type: flagSetter);
  return component;
}

Future<QCircuit> _buildFlagResetterGate(ShorBuilders shorBuilders,
    QRegister qreg, QRegister qflag, QGateBuilder builder) async {
  final gate = await shorBuilders.resetFlagGate(qreg.qubits, qflag[0]);
  final component = QCircuit(builder);
  component.custom([...qreg.qubits, ...qflag.qubits], gate, type: flagResetter);
  return component;
}

Future<QCircuit> _buildQftGate(
    ShorBuilders shorBuilders, QRegister qreg, QGateBuilder builder) async {
  final gate = await shorBuilders.qftGate(qreg.qubits);
  final component = QCircuit(builder);
  component.custom(qreg, gate, type: QGateType.qft);
  return component;
}

Future<QCircuit> _buildInvQftGate(
    ShorBuilders shorBuilders, QRegister qreg, QGateBuilder builder) async {
  final gate = await shorBuilders.invQftGate(qreg.qubits);
  final component = QCircuit(builder);
  component.custom(qreg, gate, type: QGateType.invqft);
  return component;
}

Future<QCircuit> _buildAddModuloGate(
    ShorBuilders shorBuilders,
    int constant,
    int modulo,
    QCircuit addModuloGate,
    QCircuit addModuloIfFlagGate,
    QCircuit subModuloGate,
    QCircuit flagSetterGate,
    QCircuit flagResetterGate,
    QRegister qreg,
    QGateBuilder builder) async {
  final params = {'x': constant};
  final addConstantCircuit =
      await _buildAddGate(shorBuilders, constant, qreg, builder);
  final subConstantCircuit = QCircuit(builder)
      .append(addConstantCircuit, dagger: true)
      .compile(type: subtractor, params: params);

  return QCircuit(builder)
      .append(addConstantCircuit, merge: false)
      .append(subModuloGate, merge: false)
      .append(flagSetterGate, merge: false)
      .append(addModuloIfFlagGate, merge: false)
      .append(subConstantCircuit, merge: false)
      .append(flagResetterGate, merge: false)
      .append(addConstantCircuit, merge: false);
}

Future<QCircuit> _buildMultiplyAndAddModuloGate(
    ShorBuilders shorBuilders,
    int constant,
    int modulo,
    QRegister qzeroext,
    QRegister qvalue,
    QRegister qflag,
    QRegister qctrl,
    QCircuit qftGate,
    QCircuit invQftGate,
    QCircuit flagSetterGate,
    QCircuit flagResetterGate,
    QGateBuilder builder) async {
  final params = {'x': modulo};

  final addModuloGate =
      await _buildAddGate(shorBuilders, modulo, qzeroext, builder);

  final subModuloGate = QCircuit(builder)
      .append(addModuloGate, dagger: true)
      .compile(type: subtractor, params: params);
  final addModuloIfFlagGate = QCircuit(builder)
      .append(addModuloGate, controls: qflag)
      .compile(type: adder, params: params);

  final component = QCircuit(builder);
  final size = qvalue.size;

  component.append(qftGate, controls: qctrl, merge: false);

  component.separation(
      label:
          '================ BEGIN ${qzeroext.name} + $constant * ${qvalue.name} % $modulo ================',
      merge: false);

  final gates = await Future.wait(Iterable.generate(size, (i) {
    final n = constant * (1 << i);
    return _buildAddModuloGate(
        shorBuilders,
        n % modulo,
        modulo,
        addModuloGate,
        addModuloIfFlagGate,
        subModuloGate,
        flagSetterGate,
        flagResetterGate,
        qzeroext,
        builder);
  }));

  for (var i = 0; i < size; i++) {
    final n = constant * (1 << i);
    component.separation(
        label:
            '================ ADD $n MODULO $modulo = ADD ${n % modulo} % MODULO $modulo CONTROLLED BY #${qvalue[size - 1 - i]} ================',
        merge: false);
    component.append(gates[i],
        controls: [qvalue[size - 1 - i], qctrl[0]], merge: false);
  }
  component.separation(
      label:
          '================ END ${qzeroext.name} + $constant * ${qvalue.name} % $modulo ================',
      merge: false);

  component.append(invQftGate, controls: qctrl[0], merge: false);

  return component;
}

Future<QCircuit> _buildSwapperGate(ShorBuilders shorBuilders, QRegister qa,
    QRegister qb, QRegister qctrl, QGateBuilder builder) async {
  final gate = await shorBuilders.swapperGate(qa.qubits, qb.qubits);
  final component = QCircuit(builder);
  component.custom([...qa.qubits, ...qb.qubits], gate,
      controls: qctrl, type: swapper, params: {'a': qa.name, 'b': qb.name});
  return component;
}

int inverse(int constant, int modulo) {
  for (var i = 1; i < modulo; i++) {
    if ((i * constant) % modulo == 1) return i;
  }
  return 0;
}

Future<QCircuit> buildModularMultiplierGate(
    ShorBuilders shorBuilders,
    int constant,
    int modulo,
    QRegister qvalue,
    QRegister qzero,
    QRegister qzeroext,
    QRegister qctrl,
    QRegister qflag,
    QGateBuilder builder) async {
  final inv = inverse(constant, modulo);
  if (inv == 0) {
    throw Exception(
        'Invalid parameters: constant $constant and modulo $modulo must be coprime');
  }

  final program = QCircuit(builder);

  final components = await Future.wait([
    _buildQftGate(shorBuilders, qzeroext, builder),
    _buildInvQftGate(shorBuilders, qzeroext, builder),
    _buildFlagSetterGate(shorBuilders, qzeroext, qflag, builder),
    _buildFlagResetterGate(shorBuilders, qzeroext, qflag, builder),
  ]);

  final qftGate = components[0];
  final invQftGate = components[1];
  final flagSetterGate = components[2];
  final flagResetterGate = components[3];

  final mulGates = await Future.wait([
    _buildMultiplyAndAddModuloGate(
        shorBuilders,
        constant,
        modulo,
        qzeroext,
        qvalue,
        qflag,
        qctrl,
        qftGate,
        invQftGate,
        flagSetterGate,
        flagResetterGate,
        builder),
    _buildMultiplyAndAddModuloGate(
        shorBuilders,
        inv,
        modulo,
        qzeroext,
        qvalue,
        qflag,
        qctrl,
        qftGate,
        invQftGate,
        flagSetterGate,
        flagResetterGate,
        builder),
    _buildSwapperGate(shorBuilders, qvalue, qzero, qctrl, builder),
  ]);

  final mulConstantGate = mulGates[0];
  final mulInverseGate = mulGates[1];
  final swapperGate = mulGates[2];

  program.append(mulConstantGate, merge: false);
  program.append(swapperGate, merge: false);
  program.append(mulInverseGate, dagger: true, merge: false);

  return program;
}

Future main() async {
  final sw = Stopwatch();
  sw.start();

  Squadron.setId('main');
  Squadron.setLogger(ConsoleSquadronLogger());
  Squadron.logLevel = SquadronLogLevel.fine;

  Squadron.info('Program started');

  // see https://medium.com/mit-6-s089-intro-to-quantum-computing/a-general-implementation-of-shors-algorithm-da1595694430

  final modulo = 7;
  final constant = 2;

  final bits = 3;
  final size = 2 * bits + 3;

  final qmem = QMemorySpace.zero(size);

  // memory layout:
  //
  //     1    <--bits--> <--bits-->    1       1
  // | qctrl |  qvalue  |  qzero   | carry | qflag |
  // | qctrl |  qvalue  |      qzeroext    | qflag |
  //     1    <- bits -> <--- bits + 1 --->    1

  final qctrl = qmem.createRegister('CTRL', at: 0);
  final qvalue = qmem.createRegister('VALUE', from: bits, to: 1); // LSB first
  final qzeroext = qmem.createRegister('ZERO-EXT',
      from: 2 * bits + 1, to: bits + 1); // LSB first
  final qzero = qmem.createRegister('ZERO', from: 2 * bits, to: bits + 1);
  final qflag = qmem.createRegister('FLAG', at: 2 * bits + 2);

  Squadron.info('=== PARAMETERS ===');
  Squadron.info('   * modulo = $modulo');
  Squadron.info('   * constant = $constant');
  Squadron.info(' ');
  Squadron.info('=== REGISTERS ===');
  Squadron.info('   * $qctrl');
  Squadron.info('   * $qvalue');
  Squadron.info('   * $qzeroext');
  Squadron.info('   * $qzero');
  Squadron.info('   * $qflag');
  Squadron.info(' ');

  final builder = QGateBuilder.get(qmem.size, withCache: true);

  ShorBuilders shorBuilders = ShorBuildersPool(builder.size,
      ConcurrencySettings(minWorkers: 4, maxWorkers: 4, maxParallel: 1));
  // ShorBuilders shorBuilders = ShorBuildersImpl(builder.size);

  if (shorBuilders is ShorBuildersPool) {
    await shorBuilders.start();
  }

  QCircuit program;
  try {
    // this program is at the heart of Shor's algorithm

    // expected inputs:
    //  * qctrl    = |0> or |1>
    //  * qvalue   = |n>
    //  * qzeroext = |0>
    //  * qflag    = |0>

    // expected results:
    //  * qctrl    = |0> or |1> (unchanged)
    //  * qvalue   = |n> if qctrl = |0>, |(n * constant) % modulo> if qctrl = |1>
    //  * qzeroext = |0> (unchanged)
    //  * qflag    = |0> (unchanged)

    Squadron.info('Building program...');
    program = await buildModularMultiplierGate(shorBuilders, constant, modulo,
        qvalue, qzero, qzeroext, qctrl, qflag, builder);
  } finally {
    shorBuilders.clearCache();
    if (shorBuilders is ShorBuildersPool) {
      shorBuilders.stop();
      Squadron.config('WORKER STATS:');
      Squadron.config(shorBuilders.fullStats
          .map((stat) => '   - ${stat.totalWorkload} - ${stat.upTime}'));
      Squadron.config(
          'cache hits: ${shorBuilders.hits}, cache misses: ${shorBuilders.misses}');
    }
  }

  await draw(program, qmem: qmem, filePrefix: 'modmul');

  program.addObserver((step, gate, qmem) {
    if (gate != null && gate.type == QGateType.separator) {
      if (gate.label.startsWith('DBG-')) {
        Squadron.fine('     - $step: ${gate.label}: ${probInfo(qmem)}');
      } else {
        Squadron.finer('     - $step: ${gate.label}');
      }
    } else {
      Squadron.finer(
          '     - $step: ${gate?.label ?? 'START'}: ${probInfo(qmem)}');
    }
  });

  var broken = 0;

  void log(dynamic message, [bool ok = true]) =>
      ok ? Squadron.info(message) : Squadron.shout(message);

  for (var ctrl = 1; ctrl >= 0; ctrl--) {
    for (var val = 0; val < modulo; val++) {
      log(' ');

      qmem.initialize({
        qctrl: ctrl,
        qvalue: val,
      });

      final mctrl = qctrl.read();
      final mvalue = qvalue.read();
      final mzero = qzeroext.read();
      final mflag = qflag.read();

      assert(mctrl == ctrl);
      assert(mvalue == val);
      assert(mzero == 0);
      assert(mflag == 0);

      log(' ');
      log('=== INITIAL STATE ===');
      log('   * Initial values: ${qvalue.name} = $mvalue, ${qctrl.name} = $mctrl');
      log('   * Initial states: ${probInfo(qmem)}');

      program.execute(qmem);

      final rctrl = qctrl.read();
      final rvalue = qvalue.read();
      final rzero = qzero.read();
      final rflag = qflag.read();

      final expctrl = ctrl;
      final expvalue = (ctrl == 0) ? val : ((val * constant) % modulo);
      final expzero = 0;
      final expflag = 0;

      log('=== FINAL STATE ===');
      log('   * Final states: ${probInfo(qmem)}');
      if (ctrl == 0) {
        log('   * Expectation: ctrl = 0 => $val');
      } else {
        log('   * Expectation: ctrl = 1 => ($val * $constant) % $modulo = ${val * constant} % $modulo = ${(val * constant) % modulo}');
      }
      log('   * Result:');
      log('     * ${qctrl.name} = $expctrl => $rctrl ${rctrl == expctrl ? 'OK' : 'KO'}',
          rctrl == expctrl);
      log('     * ${qvalue.name} = $expvalue => $rvalue ${rvalue == expvalue ? 'OK' : 'KO'}',
          rvalue == expvalue);
      log('     * ${qzero.name} = $expzero => $rzero ${rzero == expzero ? 'OK' : 'KO'}',
          rzero == expzero);
      log('     * ${qflag.name} = $expflag => $rflag ${rflag == expflag ? 'OK' : 'KO'}',
          rflag == expflag);
      if (rctrl != expctrl ||
          rvalue != expvalue ||
          rzero != expzero ||
          rflag != expflag) {
        broken++;
      }
    }
  }

  if (broken == 0) {
    Squadron.warning('All tests passed');
  } else {
    Squadron.shout('$broken tests failed');
  }

  sw.stop();
  Squadron.warning('Program completed in ${sw.elapsed}');

  if (broken > 0) {
    throw Exception('$broken tests failed');
  }
}
