import 'package:bq_health/src/components/result.dart';
import 'package:flutter/material.dart';

class FormImc extends StatefulWidget {
  const FormImc({super.key});

  @override
  State<FormImc> createState() => _FormImcState();
}

class _FormImcState extends State<FormImc> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  // Função para validar se o valor é numérico
  bool _isNumeric(String value) {
    if (value.isEmpty) {
      return false;
    }
    final number = num.tryParse(value);
    return number != null;
  }

  void _calcularIMC() {
    final pesoText = _pesoController.text;
    final alturaText = _alturaController.text;

    if (_isNumeric(pesoText) && _isNumeric(alturaText)) {
      final peso = double.parse(pesoText);
      final altura = double.parse(alturaText);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(peso: peso, altura: altura),
        ),
      );
    } else {
      // Mostra uma mensagem de erro se os valores não forem numéricos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Por favor, insira valores válidos para peso e altura.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        TextFormField(
          controller: _pesoController,
          decoration: const InputDecoration(
            icon: Icon(Icons.scale),
            hintText: 'Qual seu peso?',
            labelText: 'Peso (kg)',
          ),
          keyboardType: TextInputType.number, // Permite inserir apenas números
        ),
        TextFormField(
          controller: _alturaController,
          decoration: const InputDecoration(
            icon: Icon(Icons.height),
            hintText: 'Qual sua altura?',
            labelText: 'Altura (m)',
          ),
          keyboardType: TextInputType.number, // Permite inserir apenas números
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _calcularIMC,
            style: styleButton,
            child: const Text(
              'Calcular',
              style: TextStyle(fontSize: 20),
            ),
          ),
        )
      ],
    ));
  }
}

var styleButton = ElevatedButton.styleFrom(
  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  backgroundColor: const Color.fromARGB(255, 94, 0, 27),
  elevation: 10, // Elevation
  shadowColor: const Color.fromARGB(255, 158, 158, 158),
);
