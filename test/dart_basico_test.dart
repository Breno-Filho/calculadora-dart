import 'package:dart_basico/dart_basico.dart';
import 'package:test/test.dart';

void main() {
  group('Testes da Calculadora', () {
    late Calculadora calc;

    setUp(() {
      calc = Calculadora();
    });

    test('Teste de soma', () {
      expect(calc.somar(5, 3), equals(8));
      expect(calc.somar(-2, 7), equals(5));
      expect(calc.somar(0, 0), equals(0));
      expect(calc.somar(2.5, 1.5), equals(4));
    });

    test('Teste de subtração', () {
      expect(calc.subtrair(10, 4), equals(6));
      expect(calc.subtrair(5, 8), equals(-3));
      expect(calc.subtrair(0, 5), equals(-5));
      expect(calc.subtrair(7.5, 2.5), equals(5));
    });

    test('Teste de multiplicação', () {
      expect(calc.multiplicar(4, 3), equals(12));
      expect(calc.multiplicar(-2, 5), equals(-10));
      expect(calc.multiplicar(0, 100), equals(0));
      expect(calc.multiplicar(2.5, 4), equals(10));
    });

    test('Teste de divisão', () {
      expect(calc.dividir(10, 2), equals(5));
      expect(calc.dividir(7, 2), equals(3.5));
      expect(calc.dividir(-10, 5), equals(-2));
      expect(calc.dividir(0, 5), equals(0));
    });

    test('Teste de divisão por zero', () {
      expect(() => calc.dividir(10, 0), throwsException);
      expect(() => calc.dividir(-5, 0), throwsException);
    });

    group('Testes do Parser de Expressões', () {
      test('Expressões simples', () {
        expect(calc.avaliarExpressao('2 + 2'), equals(4));
        expect(calc.avaliarExpressao('5 - 3'), equals(2));
        expect(calc.avaliarExpressao('4 * 3'), equals(12));
        expect(calc.avaliarExpressao('8 / 2'), equals(4));
      });

      test('Expressões sem espaços', () {
        expect(calc.avaliarExpressao('2+2'), equals(4));
        expect(calc.avaliarExpressao('10-5'), equals(5));
        expect(calc.avaliarExpressao('3*4'), equals(12));
        expect(calc.avaliarExpressao('15/3'), equals(5));
      });

      test('Expressões com múltiplas operações', () {
        expect(calc.avaliarExpressao('2 + 3 * 4'), equals(14)); // 2 + 12 = 14
        expect(calc.avaliarExpressao('10 - 2 * 3'), equals(4)); // 10 - 6 = 4
        expect(calc.avaliarExpressao('2 * 3 + 4'), equals(10)); // 6 + 4 = 10
        expect(calc.avaliarExpressao('20 / 4 + 3'), equals(8)); // 5 + 3 = 8
      });

      test('Expressões com precedência de operadores', () {
        expect(calc.avaliarExpressao('2 + 2 / 2'), equals(3)); // 2 + 1 = 3
        expect(calc.avaliarExpressao('6 / 2 * 3'), equals(9)); // 3 * 3 = 9
        expect(calc.avaliarExpressao('1 + 2 * 3 + 4'), equals(11)); // 1 + 6 + 4 = 11
      });

      test('Números decimais', () {
        expect(calc.avaliarExpressao('2.5 + 1.5'), equals(4));
        expect(calc.avaliarExpressao('3.2 * 2'), equals(6.4));
        expect(calc.avaliarExpressao('7.5 / 2.5'), equals(3));
      });

      test('Números negativos', () {
        expect(calc.avaliarExpressao('-5 + 3'), equals(-2));
        expect(calc.avaliarExpressao('10 + -5'), equals(5));
        expect(calc.avaliarExpressao('-2 * 3'), equals(-6));
      });

      test('Expressões inválidas', () {
        expect(() => calc.avaliarExpressao(''), throwsException);
        expect(() => calc.avaliarExpressao('2 +'), throwsException);
        expect(() => calc.avaliarExpressao('+ 2'), throwsException);
        expect(() => calc.avaliarExpressao('2 / 0'), throwsException);
      });
    });
  });

  test('Teste da função calculate', () {
    expect(calculate(), equals(42));
  });
}
