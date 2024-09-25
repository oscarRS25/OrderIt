"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_middleware_1 = require("../middlewares/auth.middleware");
const user_controller_1 = __importDefault(require("../controllers/user.controller"));
class UserRoutes {
    constructor() {
        this.router = (0, express_1.Router)();
        this.config();
    }
    config() {
        this.router.post('/', user_controller_1.default.registrarUsuario);
        this.router.post('/login', user_controller_1.default.login);
        // Prueba para verificar que funcione el token
        this.router.get('/', auth_middleware_1.verifyToken, user_controller_1.default.obtenerUsuarios);
        // Este es de prueba, puede servir en un futuro
        this.router.post('/validarEmailTel/', auth_middleware_1.verifyToken, user_controller_1.default.validarTelefonoEmail);
    }
}
const userRoutes = new UserRoutes();
exports.default = userRoutes.router;
