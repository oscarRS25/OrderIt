"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.userController = void 0;
const connection_1 = __importDefault(require("../connection"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
class UserController {
    registrarUsuario(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const usuario = req.body;
                // Encriptar la contraseña
                const salt = yield bcryptjs_1.default.genSalt(10);
                usuario.password = yield bcryptjs_1.default.hash(usuario.password, salt);
                // Registrarlo en base de datos
                const result = yield connection_1.default.query("INSERT INTO user SET ?", [usuario]);
                res.status(201).json({
                    message: "Se registró el usuario correctamente",
                    insertedId: result.insertId,
                });
            }
            catch (error) {
                console.error("Error al registrar el usuario:", error);
                res.status(500).json({ message: "Error al registrar el usuario" });
            }
        });
    }
    login(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const { email, password } = req.body;
                const result = yield connection_1.default.query("SELECT u.id, u.nombre, u.apePat, u.apeMat, u.password FROM user as u WHERE u.email = ?", [email]);
                if (result.length > 0) {
                    const user = result[0];
                    const passwordMatch = yield bcryptjs_1.default.compare(password, user.password);
                    if (passwordMatch) {
                        const payload = {
                            id: user.id,
                            nombre: `${user.nombre} ${user.apePat} ${user.apeMat}`,
                        };
                        const token = jsonwebtoken_1.default.sign(payload, 'oxIJjs8XYPjNk1hXsaeoybsVU9tx90byhpU6FSa90--6iWM45UlsDkFG5X9q4Rs3');
                        res.status(200).json({ message: 'El usuario se ha logueado', token });
                    }
                    else {
                        res.status(401).json({ message: 'Credenciales incorrectas' });
                    }
                }
                else {
                    res.status(401).json({ message: 'Credenciales incorrectas' });
                }
            }
            catch (error) {
                console.error('Error al iniciar sesión:', error);
                res.status(500).json({ message: 'Error al iniciar sesión' });
            }
        });
    }
    // Prueba para asegurarse de que el token y el middleware funciona
    obtenerUsuarios(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const usuarios = yield connection_1.default.query("SELECT * from user");
            if (usuarios.length > 0) {
                return res.json(usuarios);
            }
        });
    }
    validarTelefonoEmail(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const { email, telefono } = req.body;
                // Verificar si el correo ya está registrado
                const usuarioCorreo = yield connection_1.default.query("SELECT * FROM usuario WHERE email = ?", [email]);
                if (usuarioCorreo.length > 0) {
                    return res.status(400).json({ message: "El correo electrónico ya ha sido registrado" });
                }
                // Verificar si el teléfono ya está registrado
                const usuarioTelefono = yield connection_1.default.query("SELECT * FROM usuario WHERE telefono = ?", [telefono]);
                if (usuarioTelefono.length > 0) {
                    return res.status(400).json({ message: "El teléfono ya ha sido registrado" });
                }
                // Si el correo y el teléfono no están registrados, retornar éxito
                res.status(200).json({ message: "El correo y el teléfono están disponibles para registro" });
            }
            catch (error) {
                console.error("Error al validar el correo y el teléfono:", error);
                res.status(500).json({ message: "Error al validar el correo y el teléfono" });
            }
        });
    }
}
exports.userController = new UserController();
exports.default = exports.userController;
