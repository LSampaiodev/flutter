import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/api_service.dart';
import 'add_language_screen.dart';

class LanguageListScreen extends StatefulWidget {
  const LanguageListScreen({super.key});

  @override
  _LanguageListScreenState createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {
  final ApiService _apiService = ApiService();
  List<Language> _languages = [];

  @override
  void initState() {
    super.initState();
    _loadLanguages();
  }

  Future<void> _loadLanguages() async {
    try {
      final languages = await _apiService.getLanguages();
      setState(() {
        _languages = languages;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar linguagens')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linguagens de Programação'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadLanguages,
        child: ListView.builder(
          itemCount: _languages.length,
          itemBuilder: (context, index) {
            final language = _languages[index];
            return ListTile(
              title: Text(language.name),
              subtitle: Text(language.description),
              trailing:
                  Text('${(language.progress * 100).toStringAsFixed(0)}%'),
              onTap: () => _showLanguageDetails(language),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewLanguage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewLanguage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdddLanguageScreen(
          onLanguageAdded: (Language newLanguage) {
            setState(() {
              _languages.add(newLanguage);
            });
          },
        ),
      ),
    );
  }

  void _showLanguageDetails(Language language) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(language.name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Descrição: ${language.description}'),
            const SizedBox(height: 10),
            Text('Progresso: ${(language.progress * 100).toStringAsFixed(0)}%'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          TextButton(
            onPressed: () => _deleteLanguage(language),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _deleteLanguage(Language language) async {
    try {
      await _apiService.deleteLanguage(language.id!);
      Navigator.pop(context);
      setState(() {
        _languages.removeWhere((l) => l.id == language.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Linguagem excluída com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir linguagem')),
      );
    }
  }
}
