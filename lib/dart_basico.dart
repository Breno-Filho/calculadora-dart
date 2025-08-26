/// Classe Calculadora com operações básicas e parser de expressões
class Calculadora {
  /// Soma dois números
  double somar(double a, double b) {
    return a + b;
  }

  /// Subtrai o segundo número do primeiro
  double subtrair(double a, double b) {
    return a - b;
  }

  /// Multiplica dois números
  double multiplicar(double a, double b) {
    return a * b;
  }

  /// Divide o primeiro número pelo segundo
  /// Retorna null se o divisor for zero
  double? dividir(double a, double b) {
    if (b == 0) {
      throw Exception('Erro: Divisão por zero não é permitida!');
    }
    return a / b;
  }

  /// Avalia uma expressão matemática como string
  /// Suporta operações: +, -, *, /
  /// Exemplo: "2 + 3 * 4" retorna 14
  double avaliarExpressao(String expressao) {
    // Remove espaços em branco
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

  /// Método recursivo para avaliar expressões respeitando precedência
  double _avaliarExpressaoRecursiva(String expressao) {
    // Remove parênteses externos se existirem
    expressao = _removerParentesesExternos(expressao);
    
    // Validações básicas
    if (expressao.isEmpty) {
      throw Exception('Expressão vazia');
    }
    
    // Verifica se termina com operador
    if (expressao.endsWith('+') || expressao.endsWith('-') || 
        expressao.endsWith('*') || expressao.endsWith('/')) {
      throw Exception('Expressão termina com operador');
    }
    
    // Verifica se começa com operador (exceto - para números negativos)
    if (expressao.startsWith('+') || expressao.startsWith('*') || expressao.startsWith('/')) {
      throw Exception('Expressão inválida');
    }
    
    // Procura por + ou - (menor precedência) da direita para esquerda
    for (int i = expressao.length - 1; i >= 0; i--) {
      if (expressao[i] == '+' || expressao[i] == '-') {
        // Verifica se não é um sinal de número negativo
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
    
    // Procura por * ou / (maior precedência) da direita para esquerda
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
    
    // Se chegou aqui, deve ser um número
    try {
      return double.parse(expressao);
    } catch (e) {
      throw Exception('Número inválido: $expressao');
    }
  }

  /// Remove parênteses externos desnecessários
  String _removerParentesesExternos(String expressao) {
    while (expressao.startsWith('(') && expressao.endsWith(')')) {
      // Verifica se os parênteses são balanceados
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

  /// Verifica se o caractere é um dígito, ponto decimal ou parêntese de fechamento
  bool _isNumeroOuParenteses(String char) {
    return char.contains(RegExp(r'[0-9\.]')) || char == ')';
  }
}

/// Função auxiliar para manter compatibilidade
int calculate() {
  return 42; // Resposta para a pergunta fundamental da vida, universo e tudo mais
}
