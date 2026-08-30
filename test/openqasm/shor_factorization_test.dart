import 'package:test/test.dart';

import '../../example/openqasm/shor_factorization.dart';

void main() {
  group('Shor classical follow-up', () {
    test('phase estimates the correct order for N=15 and a=7', () {
      final order = phaseToOrder(9, 4, 7, 15);
      expect(order, equals(1));
    });

    test('order-based factorization recovers non-trivial factors', () {
      final factors = factorFromOrder(15, 7, 4);
      expect(factors, containsAll([3, 5]));
    });

    test('rejects invalid order candidates before factoring', () {
      final invalidOrder = phaseToOrder(12, 6, 14, 33);
      expect(invalidOrder, equals(1));
      expect(factorFromOrder(33, 14, invalidOrder), isEmpty);
    });

    test('generates a QASM program for a chosen N and a', () {
      final source = generateShorQasm(15, 7, 4);
      expect(source, contains('OPENQASM 3.0;'));
      expect(source, contains('const int N = 15;'));
      expect(source, contains('const int a = 7;'));
      expect(source, contains('cp((tau * 2) / 15) y_reg[0], x_reg[0];'));
      expect(source, contains('cp((tau * 8) / 15) y_reg[2], x_reg[1];'));
    });
  });
}
