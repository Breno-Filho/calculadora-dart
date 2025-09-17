class Calculadora {

  double somar(double a, double b) {
    return a + b;
  }

  double subtrair(double a, double b) {
    return a - b;
  }

  double multiplicar(double a, double b) {
    return a * b;
  }

  double? dividir(double a, double b) {
    if (b == 0) {
      throw Exception('Erro: Divisão por zero não é permitida!');
    }
    return a / b;
  }

  double avaliarExpressao(String expressao) {

    expressao = expressao.replaceAll(' ', '');
    
    if (expressao.isEmpty) {
      throw Exception('Expressão vazia');
    }

    try {
      return _avaliarExpressaoRecursiva(expressao);
    } catch (e) {
      throw Exception('Erro ao avaliar expressão: $e');
    }
  }

  double _avaliarExpressaoRecursiva(String expressao) {
    expressao = _removerParentesesExternos(expressao);

    if (expressao.isEmpty) {
      throw Exception('Expressão vazia');
    }
    
    if (expressao.endsWith('+') || expressao.endsWith('-') || 
        expressao.endsWith('*') || expressao.endsWith('/')) {
      throw Exception('Expressão termina com operador');
    }
    
    if (expressao.startsWith('+') || expressao.startsWith('*') || expressao.startsWith('/')) {
      throw Exception('Expressão inválida');
    }
    
    for (int i = expressao.length - 1; i >= 0; i--) {
      if (expressao[i] == '+' || expressao[i] == '-') {
        if (i > 0 && _isNumeroOuParenteses(expressao[i - 1])) {
          String esquerda = expressao.substring(0, i);
          String direita = expressao.substring(i + 1);
          
          if (esquerda.isEmpty || direita.isEmpty) {
            throw Exception('Operando faltando');
          }
          
          double valorEsquerda = _avaliarExpressaoRecursiva(esquerda);
          double valorDireita = _avaliarExpressaoRecursiva(direita);
          
          if (expressao[i] == '+') {
            return somar(valorEsquerda, valorDireita);
          } else {
            return subtrair(valorEsquerda, valorDireita);
          }
        }
      }
    }
    
    for (int i = expressao.length - 1; i >= 0; i--) {
      if (expressao[i] == '*' || expressao[i] == '/') {
        String esquerda = expressao.substring(0, i);
        String direita = expressao.substring(i + 1);
        
        if (esquerda.isEmpty || direita.isEmpty) {
          throw Exception('Operando faltando');
        }
        
        double valorEsquerda = _avaliarExpressaoRecursiva(esquerda);
        double valorDireita = _avaliarExpressaoRecursiva(direita);
        
        if (expressao[i] == '*') {
          return multiplicar(valorEsquerda, valorDireita);
        } else {
          var resultado = dividir(valorEsquerda, valorDireita);
          if (resultado == null) {
            throw Exception('Divisão por zero');
          }
          return resultado;
        }
      }
    }
    
    try {
      return double.parse(expressao);
    } catch (e) {
      throw Exception('Número inválido: $expressao');
    }
  }

  String _removerParentesesExternos(String expressao) {
    while (expressao.startsWith('(') && expressao.endsWith(')')) {
      int contador = 0;
      bool podeRemover = true;
      
      for (int i = 0; i < expressao.length - 1; i++) {
        if (expressao[i] == '(') contador++;
        if (expressao[i] == ')') contador--;
        if (contador == 0) {
          podeRemover = false;
          break;
        }
      }
      
      if (podeRemover) {
        expressao = expressao.substring(1, expressao.length - 1);
      } else {
        break;
      }
    }
    return expressao;
  }

  bool _isNumeroOuParenteses(String char) {
    return char.contains(RegExp(r'[0-9\.]')) || char == ')';
  }
}
