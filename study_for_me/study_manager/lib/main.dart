import 'package:flutter/material.dart';
import 'screens/language_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Estudos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LanguageListScreen(), // Tela inicial do aplicativo
      routes: {
        '/add': (context) => const SimpleAddScreen(), // Tela temporária simples para testar
      },
    );
  }
}

class SimpleAddScreen extends StatelessWidget {
  const SimpleAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}
