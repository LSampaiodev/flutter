import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/api_service.dart';

class AdddLanguageScreen extends StatelessWidget {
  final Function(Language) onLanguageAdded;

  AdddLanguageScreen({super.key, required this.onLanguageAdded});

  final ApiService _apiService = ApiService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Nova Linguagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da Linguagem'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: const Text('Adicionar Linguagem'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    final name = _nameController.text;
    final description = _descriptionController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira o nome da linguagem')),
      );
      return;
    }

    try {
      final newLanguage = await _apiService.createLanguage(
        Language(name: name, description: description, progress: 0),
      );
      onLanguageAdded(newLanguage);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao adicionar linguagem')),
      );
    }
  }
}
