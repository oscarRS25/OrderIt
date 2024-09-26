class User {
  String apePat;
  String apeMat;
  String nombre;
  String email;
  String password;

  User({
    this.apePat ='',
    this.apeMat = '',
    this.nombre = '',
    required this.email, 
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'apePat': apePat,
      'apeMat': apeMat,
      'nombre': nombre,
      'email': email,
      'password': password,
    };
  }
}