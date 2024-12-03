create database orderit;
use orderit;

CREATE TABLE Restaurantes (
  id_restaurante INT PRIMARY KEY,
  nombre VARCHAR(50),
  direccion VARCHAR(100),
  correo VARCHAR(50),
  contrasena VARCHAR(50),
  costo_envio DECIMAL(10, 2),
  min_compra_envio_gratis DECIMAL(10, 2)
);

CREATE TABLE Clientes (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(50),
  correo VARCHAR(50),
  contrasena VARCHAR(50)
);

CREATE TABLE Productos (
  id_producto INT PRIMARY KEY,
  id_restaurante INT,
  nombre VARCHAR(50),
  descripcion VARCHAR(100),
  precio DECIMAL(10, 2),
  categoria VARCHAR(50),
  FOREIGN KEY (id_restaurante) REFERENCES Restaurantes(id_restaurante)
);

CREATE TABLE Pedidos (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  id_restaurante INT,
  fecha_pedido DATE,
  estado_pedido VARCHAR(50),
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_restaurante) REFERENCES Restaurantes(id_restaurante)
);

CREATE TABLE Detalles_Pedido (
  id_detalle_pedido INT PRIMARY KEY,
  id_pedido INT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE Notificaciones (
  id_notificacion INT PRIMARY KEY,
  id_pedido INT,
  mensaje VARCHAR(100),
  fecha_notificacion DATE,
  FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);