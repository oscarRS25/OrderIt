import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final AuthController authController = AuthController();
  final TextEditingController apePatController = TextEditingController();
  final TextEditingController apeMatController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isButtonEnabled = false;

  late AnimationController _buttonController;
  late Animation<Offset> _buttonSlideAnimation;

  late AnimationController _titleController;
  late Animation<double> _titleScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Escuchamos cambios en los campos para habilitar o deshabilitar el botón
    apePatController.addListener(validateFields);
    apeMatController.addListener(validateFields);
    nombreController.addListener(validateFields);
    emailController.addListener(validateFields);
    passwordController.addListener(validateFields);
    confirmPasswordController.addListener(validateFields);

    // Configuramos animación para el botón
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Fuera de la vista (abajo)
      end: const Offset(0, 0), // Posición original
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );

    // Configuramos animación de pop para el título
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _titleScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void validateFields() {
    setState(() {
      isButtonEnabled = apePatController.text.isNotEmpty &&
          apeMatController.text.isNotEmpty &&
          nombreController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;

      // Controlamos la animación según el estado del botón
      if (isButtonEnabled) {
        _buttonController.forward();
      } else {
        _buttonController.reverse();
      }
    });
  }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    apePatController.dispose();
    apeMatController.dispose();
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _buttonController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE63946),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _titleScaleAnimation,
                    child: const Text(
                      '¡Únete a OrderIt!',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE63946),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Crea tu cuenta y comienza a disfrutar de deliciosos platillos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            buildTextField(
                controller: apePatController, label: 'Apellido Paterno'),
            const SizedBox(height: 16),
            buildTextField(
                controller: apeMatController, label: 'Apellido Materno'),
            const SizedBox(height: 16),
            buildTextField(controller: nombreController, label: 'Nombre'),
            const SizedBox(height: 16),
            buildTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            buildPasswordField(
              controller: passwordController,
              visible: passwordVisible,
              labelText: 'Contraseña',
              onToggle: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            const SizedBox(height: 16),
            buildPasswordField(
              controller: confirmPasswordController,
              visible: confirmPasswordVisible,
              labelText: 'Confirmar Contraseña',
              onToggle: () {
                setState(() {
                  confirmPasswordVisible = !confirmPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _buttonSlideAnimation, // Desplazamiento del botón
              child: AnimatedOpacity(
                opacity: isButtonEnabled ? 1.0 : 0.5, // Cambia la opacidad
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? register : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE63946),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Crear cuenta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFFFE6E6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required bool visible,
    required String labelText,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFFE63946),
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: const Color(0xFFFFE6E6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
