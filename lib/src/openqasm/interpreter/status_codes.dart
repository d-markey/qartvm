import 'value.dart';

abstract class StatusCode {
  const StatusCode();
}

class Done extends StatusCode {
  const Done._();

  factory Done() => _instance;

  static const _instance = Done._();

  @override
  String toString() => '(done)';
}

class Break extends StatusCode {
  const Break._();

  factory Break() => _instance;

  static const _instance = Break._();

  @override
  String toString() => '(break)';
}

class Continue extends StatusCode {
  const Continue._();

  factory Continue() => _instance;

  static const _instance = Continue._();

  @override
  String toString() => '(continue)';
}

class Return extends StatusCode {
  Return(this.value);

  final Value value;

  @override
  String toString() => value.value.toString();
}
