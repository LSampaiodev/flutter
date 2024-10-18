import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/api_service.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({super.key});

  @override
  _AddLanguageScreenState createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<AddLanguageScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  String _name = '';
  String _description = '';
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Nova Linguagem'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome da Linguagem'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da linguagem';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              onSaved: (value) => _description = value ?? '',
            ),
            Slider(
              value: _progress,
              onChanged: (value) {
                setState(() {
                  _progress = value;
                });
              },
              min: 0,
              max: 1,
              divisions: 100,
              label: '${(_progress * 100).round()}%',
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Adicionar Linguagem'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _apiService.createLanguage(
          Language(name: _name, description: _description, progress: _progress),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar linguagem')),
        );
      }
    }
  }
}
