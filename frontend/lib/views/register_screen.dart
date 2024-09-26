// views/register_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = AuthController();
  final TextEditingController apePatController = TextEditingController();
  final TextEditingController apeMatController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register() async {
    try {
      User user = User(
        apePat: apePatController.text,
        apeMat: apeMatController.text,
        nombre: nombreController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      await authController.registerUser(user);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: apePatController, decoration: const InputDecoration(labelText: 'Apellido Paterno')),
            TextField(controller: apeMatController, decoration: const InputDecoration(labelText: 'Apellido Materno')),
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: Text('Registrar')),
          ],
        ),
      ),
    );
  }
}
