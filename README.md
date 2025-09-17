# Calculadora em Dart

Uma calculadora de console desenvolvida em Dart que permite avaliar expressões matemáticas completas.

## Funcionalidades

- ✅ Operações básicas: soma (+), subtração (-), multiplicação (*), divisão (/)
- ✅ Suporte a números decimais
- ✅ Suporte a números negativos
- ✅ Precedência de operadores (multiplicação e divisão antes de soma e subtração)
- ✅ Expressões com múltiplas operações
- ✅ Interface de linha de comando interativa

## Como usar

### Executar a calculadora

```bash
cd dart_basico
dart run
```

### Exemplos de uso

```
> 2 + 2
= 4

> 10 - 3 * 2
= 4

> 15 / 3 + 4
= 9

> 2.5 * 4
= 10

> -5 + 3
= -2
```

### Comandos

- Digite qualquer expressão matemática e pressione Enter
- Digite "sair" para encerrar o programa

## Executar testes

```bash
dart test
```

## Estrutura do projeto

```
dart_basico/
├── bin/
│   └── dart_basico.dart      # Arquivo principal da aplicação
├── lib/
│   └── dart_basico.dart      # Biblioteca com a classe Calculadora
├── test/
│   └── dart_basico_test.dart # Testes unitários
├── pubspec.yaml              # Configuração do projeto
└── README.md                 # Este arquivo
```

## Implementação

### Classe Calculadora

A classe `Calculadora` contém:

- Métodos básicos: `somar()`, `subtrair()`, `multiplicar()`, `dividir()`
- Parser de expressões: `avaliarExpressao()` que interpreta strings matemáticas
- Tratamento de precedência de operadores
- Validação de entrada e tratamento de erros

### Parser de Expressões

O parser implementa:

- Análise recursiva de expressões
- Precedência correta de operadores (* e / antes de + e -)
- Suporte a números negativos
- Tratamento de erros (divisão por zero, expressões inválidas)

## Requisitos

- Dart SDK 3.9.0 ou superior

## Licença

Este projeto é livre para uso e modificação.
