import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/language_model.dart';

class ApiService {
  final String _baseUrl =
      'http://localhost:5000/api'; // Ajuste conforme necessário
  final Duration _timeout = const Duration(seconds: 10);

  Future<List<Language>> getLanguages() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/languages')).timeout(_timeout);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Language.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar linguagens');
    }
  }

  Future<Language> createLanguage(Language language) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/languages'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(language.toJson()),
        )
        .timeout(_timeout);

    if (response.statusCode == 201) {
      return Language.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar linguagem');
    }
  }

  Future<void> deleteLanguage(String id) async {
    final response = await http
        .delete(Uri.parse('$_baseUrl/languages/$id'))
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir linguagem');
    }
  }

  Future<Language> updateLanguage(String id, Language language) async {
    final response = await http
        .put(
          Uri.parse('$_baseUrl/languages/$id'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(language.toJson()),
        )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      return Language.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar linguagem');
    }
  }
}
