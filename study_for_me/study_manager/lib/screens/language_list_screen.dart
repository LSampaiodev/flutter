import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LanguageListScreen extends StatefulWidget {
  const LanguageListScreen({super.key});

  @override
  LanguageListScreenState createState() => LanguageListScreenState();
}

class LanguageListScreenState extends State<LanguageListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _languages;

  @override
  void initState() {
    super.initState();
    _languages = _apiService.fetchLanguages(); // Chama a função para buscar as linguagens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Estudos'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _languages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma linguagem cadastrada.'));
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final language = snapshot.data?[index];
              return ListTile(
                title: Text(language['name']),
                subtitle: Text('Progresso: ${language['progress']}%'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add'); // Navega para a tela de adicionar linguagem
        },
      ),
    );
  }
}
