const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const connection = require('../db/connection');

// Registro de clientes
const registerCliente = async (req, res) => {
  const { nombre, correo, contrasena } = req.body;
  const hashedPassword = await bcrypt.hash(contrasena, 10);

  const query = `INSERT INTO Clientes (nombre, correo, contrasena) VALUES (?, ?, ?)`;
  connection.query(query, [nombre, correo, hashedPassword], (error, results) => {
    if (error) {
      return res.status(500).json({ error: 'Error al registrar cliente' });
    }
    res.status(201).json({ message: 'Cliente registrado exitosamente' });
  });
};

// Inicio de sesión
const login = (req, res) => {
  const { correo, contrasena } = req.body;

  const query = `SELECT * FROM Clientes WHERE correo = ? UNION SELECT * FROM Restaurantes WHERE correo = ?`;
  connection.query(query, [correo, correo], async (error, results) => {
    if (error || results.length === 0) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const user = results[0];
    const isPasswordValid = await bcrypt.compare(contrasena, user.contrasena);

    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const token = jwt.sign({ id: user.id_cliente || user.id_restaurante, correo, role: user.id_cliente ? 'cliente' : 'restaurante' }, 'tu_secreto', { expiresIn: '1h' });
    res.json({ token, role: user.id_cliente ? 'cliente' : 'restaurante' });
  });
};

module.exports = { registerCliente, login };
