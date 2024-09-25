import { Request, Response } from "express";
import pool from "../connection";
import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';

class UserController {

  public async registrarUsuario(req: Request, res: Response): Promise<void> {
    try {
      const usuario = req.body;

      // Encriptar la contraseña
      const salt = await bcrypt.genSalt(10);
      usuario.password = await bcrypt.hash(usuario.password, salt);

      // Registrarlo en base de datos
      const result = await pool.query("INSERT INTO user SET ?", [usuario]);

      res.status(201).json({
          message: "Se registró el usuario correctamente",
          insertedId: result.insertId,
        });
    } catch (error) {
      console.error("Error al registrar el usuario:", error);
      res.status(500).json({ message: "Error al registrar el usuario" });
    }
  }

  public async login(req: Request, res: Response): Promise<void> {
    try {
      const { email, password } = req.body;
      const result = await pool.query(
        "SELECT u.id, u.nombre, u.apePat, u.apeMat, u.password FROM user as u WHERE u.email = ?",
        [email]
      );
  
      if (result.length > 0) {
        const user = result[0];
  
        const passwordMatch = await bcrypt.compare(password, user.password);
        if (passwordMatch) {
          const payload = {
            id: user.id,
            nombre: `${user.nombre} ${user.apePat} ${user.apeMat}`,
          };
  
          const token = jwt.sign(payload, 'oxIJjs8XYPjNk1hXsaeoybsVU9tx90byhpU6FSa90--6iWM45UlsDkFG5X9q4Rs3');
          res.status(200).json({ message: 'El usuario se ha logueado', token });
        } else {
          res.status(401).json({ message: 'Credenciales incorrectas' });
        }
      } else {
        res.status(401).json({ message: 'Credenciales incorrectas' });
      }
    } catch (error) {
      console.error('Error al iniciar sesión:', error);
      res.status(500).json({ message: 'Error al iniciar sesión' });
    }
  }

  // Prueba para asegurarse de que el token y el middleware funciona
  public async obtenerUsuarios(req: Request, res: Response) {
    const usuarios = await pool.query("SELECT * from user");
    if (usuarios.length > 0) {
      return res.json(usuarios);
    }
  }

  public async validarTelefonoEmail(req: Request, res: Response): Promise<any> {
    try {
      const { email, telefono } = req.body;

      // Verificar si el correo ya está registrado
      const usuarioCorreo = await pool.query("SELECT * FROM usuario WHERE email = ?", [email]);
      if (usuarioCorreo.length > 0) {
          return res.status(400).json({ message: "El correo electrónico ya ha sido registrado" });
      }

      // Verificar si el teléfono ya está registrado
      const usuarioTelefono = await pool.query("SELECT * FROM usuario WHERE telefono = ?", [telefono]);
      if (usuarioTelefono.length > 0) {
          return res.status(400).json({ message: "El teléfono ya ha sido registrado" });
      }

      // Si el correo y el teléfono no están registrados, retornar éxito
      res.status(200).json({ message: "El correo y el teléfono están disponibles para registro" });

    } catch (error) {
        console.error("Error al validar el correo y el teléfono:", error);
        res.status(500).json({ message: "Error al validar el correo y el teléfono" });
    }
  }
}

export const userController = new UserController();
export default userController;