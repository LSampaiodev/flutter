import 'package:flutter/material.dart';
import '../models/language_model.dart';
import '../services/api_service.dart';
import 'add_language_screen.dart';

class LanguageListScreen extends StatefulWidget {
  const LanguageListScreen({Key? key}) : super(key: key);

  @override
  _LanguageListScreenState createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {
  final ApiService _apiService = ApiService();
  List<Language> _languages = [];
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
      body: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadLanguages,
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) => _buildLanguageTile(_languages[index]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewLanguage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLanguageTile(Language language) {
    return ListTile(
      leading: const Icon(Icons.code),
      title: Text(language.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(language.description),
      trailing: Text('${(language.progress * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.blue)),
      onTap: () => _showLanguageDetails(language),
    );
  }

  void _addNewLanguage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddLanguageScreen(
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
            onPressed: () => _updateLanguageProgress(language),
            child: const Text('Alterar Progresso'),
          ),
          TextButton(
            onPressed: () => _deleteLanguage(language),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _updateLanguageProgress(Language language) {
    final TextEditingController _progressController = TextEditingController(text: (language.progress * 100).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar Progresso'),
        content: TextField(
          controller: _progressController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Progresso (%)'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final progress = double.tryParse(_progressController.text) ?? 0;
              if (progress < 0 || progress > 100) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, insira um valor entre 0 e 100.')),
                );
              } else {
                setState(() {
                  language.progress = progress / 100; // Atualiza o progresso
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Progresso atualizado com sucesso!')),
                );
              }
            },
            child: const Text('Salvar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _deleteLanguage(Language language) async {
    try {
      await _apiService.deleteLanguage(language.id!);
      setState(() {
        _languages.removeWhere((l) => l.id == language.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Linguagem excluída com sucesso')),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir linguagem')),
      );
    }
  }
}
