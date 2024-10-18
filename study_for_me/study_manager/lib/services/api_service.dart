import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://seu-backend-url/api/languages';  // Mude para o URL do seu backend

  // Função para buscar todas as linguagens
  Future<List<dynamic>> fetchLanguages() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar linguagens');
    }
  }

  // Função para adicionar uma nova linguagem
  Future<void> addLanguage(String name, int progress) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'progress': progress}),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar linguagem');
    }
  }

  // Função para atualizar uma linguagem
  Future<void> updateLanguage(String id, String name, int progress) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'progress': progress}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar linguagem');
    }
  }

  // Função para deletar uma linguagem
  Future<void> deleteLanguage(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar linguagem');
    }
  }
}
