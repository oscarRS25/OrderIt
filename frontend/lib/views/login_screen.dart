import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Asegúrate de añadir este paquete
import '../controllers/auth_controller.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    try {
      await authController.login(emailController.text, passwordController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontFamily: 'Manrope',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFE63946), // Un rojo intenso
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      '¡Bienvenido a OrderIt!',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE63946),
                      ),
                    ).animate().fadeIn(
                        duration: Duration(
                            milliseconds: 1500)), // Efecto de aparición

                    SizedBox(height: 16),
                    Icon(
                      Icons.restaurant_menu, // Ícono de comida
                      color: Color(0xFFE63946),
                      size: 100, // Tamaño del ícono
                    )
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat()) // Animación en loop
                        .scale(
                          begin: Offset(0.8, 0.8), // Tamaño mínimo
                          end: Offset(1.2, 1.2), // Tamaño máximo
                          duration: Duration(
                              milliseconds:
                                  2000), // Aumentamos la duración para hacerla más lenta
                          curve: Curves.easeInOut, // Movimiento suave
                        ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Color(0xFFFFE6E6), // Fondo sutil rosado
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Color(0xFFFFE6E6), // Fondo sutil rosado
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE63946), // Rojo intenso
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ).animate().slideX(
                    // Movimiento horizontal hacia la posición original
                    begin: -1.0, // Comienza desde la izquierda de la pantalla
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                  ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(
                      color: Color(0xFFE63946),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(
                  duration: Duration(milliseconds: 1000)) // Aparece suavemente
              .moveY(
                  begin: 50,
                  end: 0,
                  duration:
                      Duration(milliseconds: 1000)), // Se desliza hacia arriba
        ),
      ),
    );
  }
}
