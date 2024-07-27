// lib/repository/auth_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl;

  AuthRepository({required this.baseUrl});

  Future<String> authenticate({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return 'Bearer ${jsonDecode(response.body)['token']}';
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
