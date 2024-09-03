import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final double peso;
  final double altura;

  const Result({super.key, required this.peso, required this.altura});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  // Função para calcular o IMC
  double _calcularIMC() {
    return widget.peso / (widget.altura * widget.altura);
  }

  // Função para determinar a categoria do IMC
  String _getCategoriaIMC(double imc) {
    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc >= 18.5 && imc < 24.9) {
      return "Peso normal";
    } else if (imc >= 25 && imc < 29.9) {
      return "Sobrepeso";
    } else {
      return "Obesidade";
    }
  }

  @override
  Widget build(BuildContext context) {
    double imc = _calcularIMC();
    String categoria = _getCategoriaIMC(imc);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado do IMC"),
        backgroundColor: const Color.fromARGB(255, 94, 0, 27),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Seu IMC é:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                imc.toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              const SizedBox(height: 20),
              Text(
                categoria,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Volta para a tela anterior
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 94, 0, 27),
                ),
                child: const Text("Voltar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
