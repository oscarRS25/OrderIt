const express = require('express');
const { registerCliente, login } = require('../controllers/authController');
const router = express.Router();

router.post('/register/cliente', registerCliente); // Registro de clientes
router.post('/login', login); // Inicio de sesión

module.exports = router;
