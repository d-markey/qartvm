import 'dart:math' as math;
import 'package:antlr4/antlr4.dart';

import '../../../exceptions.dart';
import '../../interpreter/value.dart';

class QasmContext {
  QasmContext(this._io);

  final Map<String, dynamic> _io;

  final _rootScope = <String, Variable>{};
  late final _scopes = <Map<String, Variable>>[_rootScope];
  late var _currentScope = _scopes.first;

  void enterScope() {
    _currentScope = {};
    _scopes.add(_currentScope);
  }

  void leaveScope() {
    _scopes.removeLast();
    _currentScope = _scopes.last;
  }

  Variable? find(String name) {
    for (var i = _scopes.length - 1; i >= 0; i--) {
      final scope = _scopes[i];
      final v = scope[name];
      if (v != null) {
        return v;
      } else {
        // print('$name not in scope $scope');
      }
    }
    return null;
  }

  Variable register(String name, RuleContext type,
      {bool input = false, bool output = false}) {
    Variable? v;
    if (input || output) {
      v = _rootScope[name];
      if (v == null) {
        v = Variable(name, type);
        _rootScope[name] = v;
        if (input) {
          if (!_io.containsKey(name)) {
            throw InvalidOperationException(
                'Value for input variable $name was not provided');
          }
          v.set(_io[name]);
        }
      }
    } else {
      v = _currentScope.putIfAbsent(name, () => Variable(name, type));
    }
    return v;
  }
}

class Variable {
  Variable(this.name, this.type);

  final String name;
  final RuleContext? type;
  Value? _value;

  Value? get value => _value;

  void set(dynamic value) {
    Value? val;

    if (value is Value) {
      val = value;
    } else if (value is bool) {
      val = BoolValue(value);
    } else if (value is int) {
      val = IntValue(value);
    } else if (value is double) {
      val = FloatValue(value);
    } else if (value is String) {
      val = StringValue(value);
    } else if (value is Map) {
      if (value['re'] is num && value['im'] is num) {
        val = ComplexValue(value['re'].toDouble(), value['im'].toDouble());
      } else if (value['rad'] is num) {
        val = AngleValue(value['rad'].toDouble());
      } else if (value['deg'] is num) {
        val = AngleValue((value['deg'].toDouble() * math.pi) / 180);
      }
    }

    if (val == null) {
      throw UnsupportedError(
          'Cant set variable with (${value.runtimeType}) $value');
    }

    _value = val;
  }
}

class Qubit extends Variable {
  Qubit(String name, RuleContext? type) : super(name, type);
}

class Register extends Variable {
  Register(String name, RuleContext? type) : super(name, type);
}

class Alias extends Variable {
  Alias(String name, RuleContext? type) : super(name, type);
}
