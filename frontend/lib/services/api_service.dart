// services/api_service.dart
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3000/api/users';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }

  Future<void> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()), // Enviar el usuario en formato JSON
      );

      if (response.statusCode == 201) {
        // Registro exitoso
        print('Usuario registrado correctamente');
      } else {
        // Manejar errores
        print('Error al registrar el usuario: ${response.body}');
      }
    } catch (error) {
      print('Error al conectar con la API: $error');
    }
  }
}