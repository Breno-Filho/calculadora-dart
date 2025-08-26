import 'package:dart_basico/dart_basico.dart' as dart_basico;
import 'dart:io';

void main(List<String> arguments) {
  print('=== CALCULADORA EM DART ===');
  print('Digite expressões matemáticas e pressione Enter para calcular');
  print('Operações suportadas: +, -, *, /');
  print('Exemplos: 2 + 2, 10 - 3 * 2, 15 / 3 + 4');
  print('Digite "sair" para encerrar\n');
  
  // Criar instância da calculadora
  var calc = dart_basico.Calculadora();
  
  // Loop principal da calculadora
  while (true) {
    stdout.write('> ');
    String? entrada = stdin.readLineSync();
    
    if (entrada == null || entrada.toLowerCase() == 'sair') {
      print('Obrigado por usar a calculadora!');
      break;
    }
    
    if (entrada.trim().isEmpty) {
      continue;
    }
    
    try {
      double resultado = calc.avaliarExpressao(entrada);
      
      // Formatar o resultado para exibir como inteiro se for um número inteiro
      if (resultado == resultado.truncateToDouble()) {
        print('= ${resultado.toInt()}');
      } else {
        print('= ${resultado.toStringAsFixed(2)}');
      }
    } catch (e) {
      print('Erro: $e');
      print('Verifique se a expressão está correta.');
    }
  }
}

