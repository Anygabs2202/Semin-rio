import 'package:flutter/material.dart';
import 'dart:math'; // Para operações matemáticas como seno, cosseno, tangente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Cor principal
        hintColor: Colors.blueAccent, // Cor secundária
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = ''; // Entrada do usuário
  String result = ''; // Resultado da operação

  // Função para adicionar números e operadores ao input
  void buttonPressed(String value) {
    setState(() {
      input += value;
    });
  }

  // Função para limpar o input e o resultado
  void clear() {
    setState(() {
      input = '';
      result = '';
    });
  }

  // Função para calcular expressões
  void calculate() {
    try {
      // Converte o input para expressões matemáticas
      final expression = input.replaceAll('x', '*').replaceAll('÷', '/');
      final calcResult = _parseExpression(expression);
      setState(() {
        result = calcResult.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        result = 'Erro';
      });
    }
  }

  // Função para calcular expressões simples (como soma, subtração, etc.)
  double _parseExpression(String expr) {
    if (expr.contains('+')) {
      final parts = expr.split('+');
      return double.parse(parts[0]) + double.parse(parts[1]);
    } else if (expr.contains('-')) {
      final parts = expr.split('-');
      return double.parse(parts[0]) - double.parse(parts[1]);
    } else if (expr.contains('*')) {
      final parts = expr.split('*');
      return double.parse(parts[0]) * double.parse(parts[1]);
    } else if (expr.contains('/')) {
      final parts = expr.split('/');
      return double.parse(parts[0]) / double.parse(parts[1]);
    } else {
      return double.parse(expr); // Caso só tenha um número
    }
  }

  // Função para calcular funções especiais como sen, cos, tan
  void calculateSpecialFunctions(String func) {
    try {
      double value = double.parse(input); // Converte input em número
      double calcResult;

      if (func == 'sen') {
        calcResult = sin(value);
      } else if (func == 'cos') {
        calcResult = cos(value);
      } else if (func == 'tan') {
        calcResult = tan(value);
      } else {
        return;
      }

      setState(() {
        result = calcResult.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        result = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsividade: pegar a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora Científica',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Área de exibição do input e resultado
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                input,
                style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: screenWidth * 0.12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Layout dos botões
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      screenWidth > 600
                          ? 5
                          : 4, // Responsividade para telas maiores
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  String buttonText;
                  if (index < 10) {
                    buttonText = index.toString();
                  } else if (index == 10) {
                    buttonText = '+';
                  } else if (index == 11) {
                    buttonText = '-';
                  } else if (index == 12) {
                    buttonText = 'x';
                  } else if (index == 13) {
                    buttonText = '÷';
                  } else if (index == 14) {
                    buttonText = 'C';
                  } else if (index == 15) {
                    buttonText = 'sen';
                  } else if (index == 16) {
                    buttonText = 'cos';
                  } else if (index == 17) {
                    buttonText = 'tan';
                  } else {
                    buttonText = '=';
                  }

                  return ElevatedButton(
                    onPressed: () {
                      if (buttonText == 'C') {
                        clear();
                      } else if (buttonText == '=') {
                        calculate();
                      } else if (['sen', 'cos', 'tan'].contains(buttonText)) {
                        calculateSpecialFunctions(buttonText);
                      } else {
                        buttonPressed(buttonText);
                      }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue, // Cor do texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ), // Bordas arredondadas
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
