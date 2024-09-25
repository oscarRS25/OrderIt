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
}