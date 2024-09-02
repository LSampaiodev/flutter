import 'package:bq_health/src/components/result.dart';
import 'package:flutter/material.dart';

class FormImc extends StatefulWidget {
  const FormImc({super.key});

  @override
  State<FormImc> createState() => _FormImcState();
  // _ => classe privada, uso único dentro da classe
}

class _FormImcState extends State<FormImc> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.scale),
            hintText: 'Qual seu peso?',
            labelText: 'Peso',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.height),
            hintText: 'Qual sua altura?',
            labelText: 'Altura',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Result()),
              );
            },
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
  // Shadow Color
);
//TAREFA: colocar um lugar pra peso, altura e um botão (textformfield)
