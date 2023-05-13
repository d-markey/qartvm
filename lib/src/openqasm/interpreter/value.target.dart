part of 'value.dart';

class Target extends Value {
  const Target(this.name) : super._();

  final String name;

  @override
  String toString() => 'Target($name)';
}

class IndexedTarget extends Target {
  const IndexedTarget(String name, this.indexes) : super(name);

  final List<IterableValue> indexes;

  @override
  String toString() => 'IndexedTarget($name, $indexes)';
}
