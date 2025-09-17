import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, 
      title: 'Calculadora em Dart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CalculadoraHome(),
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  const CalculadoraHome({super.key});

  @override
  State<CalculadoraHome> createState() => _CalculadoraHomeState();
}

class _CalculadoraHomeState extends State<CalculadoraHome> {
  final Calculadora _calc = Calculadora();
  String _expressao = '';
  String _resultado = '';

  void _adicionarCaractere(String caractere) {
    setState(() {
      _expressao += caractere;
    });
  }

  void _calcular() {
    try {
      double resultado = _calc.avaliarExpressao(_expressao);
      setState(() {
        _resultado = resultado == resultado.truncateToDouble()
            ? resultado.toInt().toString()
            : resultado.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro';
      });
    }
  }

  void _limpar() {
    setState(() {
      _expressao = '';
      _resultado = '';
    });
  }

  Widget _botao(String texto, {Color? cor, double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            if (texto == '=') {
              _calcular();
            } else if (texto == 'C') {
              _limpar();
            } else {
              _adicionarCaractere(texto);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: cor ?? Colors.grey[300],
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora em Dart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display da expressão
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            color: Colors.grey[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          // Display do resultado
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            color: Colors.blue[50],
            child: Text(
              _resultado,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Botões
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Linha 1: 7 8 9 /
                  Row(
                    children: [
                      _botao('7'),
                      _botao('8'),
                      _botao('9'),
                      _botao('/', cor: Colors.orange[300]),
                    ],
                  ),
                  // Linha 2: 4 5 6 *
                  Row(
                    children: [
                      _botao('4'),
                      _botao('5'),
                      _botao('6'),
                      _botao('*', cor: Colors.orange[300]),
                    ],
                  ),
                  // Linha 3: 1 2 3 -
                  Row(
                    children: [
                      _botao('1'),
                      _botao('2'),
                      _botao('3'),
                      _botao('-', cor: Colors.orange[300]),
                    ],
                  ),
                  // Linha 4: 0 . C +
                  Row(
                    children: [
                      _botao('0', flex: 2),
                      _botao('.'),
                      _botao('C', cor: Colors.red[300]),
                      _botao('+', cor: Colors.orange[300]),
                    ],
                  ),
                  // Linha 5: =
                  Row(
                    children: [
                      _botao('=', cor: Colors.green[400], flex: 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
