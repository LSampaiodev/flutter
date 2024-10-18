import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/language_model.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:5000/api'; // Ajuste conforme necessário

  Future<List<Language>> getLanguages() async {
    final response = await http.get(Uri.parse('$_baseUrl/languages'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar linguagens');
    }
  }

  Future<Language> createLanguage(Language language) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/languages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(language.toJson()),
    );

    if (response.statusCode == 201) {
      return Language.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar linguagem');
    }
  }

  Future<Language> updateLanguage(String id, Language language) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/languages/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(language.toJson()),
    );

    if (response.statusCode == 200) {
      return Language.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao atualizar linguagem');
    }
  }

  Future<void> deleteLanguage(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/languages/$id'));

    if (response.statusCode != 204) {
      throw Exception('Erro ao excluir linguagem');
    }
  }
}