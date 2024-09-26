// controllers/auth_controller.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user_model.dart';
import '../services/api_service.dart';

class AuthController {
  final ApiService apiService = ApiService();
  final storage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final result = await apiService.login(email, password);
    await storage.write(key: 'token', value: result['token']);
  }

  Future<void> registerUser(User user) async {
    await apiService.registerUser(user);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }
}
