import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user.dart';

Future<List<Users>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://127.0.0.1'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['users'];
    return jsonResponse.map((users) => Users.fromJson(users)).toList();
  } else {
    throw Exception('Failed to load Users');
  }
}
