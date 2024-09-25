import { Router } from "express";

import { verifyToken } from "../middlewares/auth.middleware";
import userController from "../controllers/user.controller";

class UserRoutes{
    
    public router: Router = Router();

    constructor() {
        this.config();
    }

    config(): void {
        this.router.post('/',userController.registrarUsuario);
        this.router.post('/login',userController.login);
        
        // Prueba para verificar que funcione el token
        this.router.get('/', verifyToken, userController.obtenerUsuarios);

        // Este es de prueba, puede servir en un futuro
        this.router.post('/validarEmailTel/', verifyToken, userController.validarTelefonoEmail);
    }
}

const userRoutes = new UserRoutes();
export default userRoutes.router;