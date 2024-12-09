-- MySQL Script generated by MySQL Workbench
-- Wed Sep 25 11:08:51 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `orderit` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `orderit` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema orderit
-- -----------------------------------------------------
USE `orderit` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orderit`.`user` ;

CREATE TABLE IF NOT EXISTS `orderit`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apePat` VARCHAR(30) NOT NULL,
  `apeMat` VARCHAR(30) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `email` VARCHAR(60) NOT NULL UNIQUE,
  `password` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla de Restaurantes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(255),
  `direccion` VARCHAR(255), -- Dirección del restaurante
  `imagen_url` VARCHAR(255), -- Imagen del restaurante
  PRIMARY KEY (`id`),
  UNIQUE (`user_id`), -- Cada usuario puede tener solo un restaurante
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla de Platillos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dish` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(255),
  `ingredientes` TEXT, -- Ingredientes del platillo
  `precio` DECIMAL(10, 2) NOT NULL, -- Precio del platillo
  `imagen_url` VARCHAR(255), -- Imagen del platillo
  `disponible` TINYINT(1) DEFAULT 1, -- Estado de disponibilidad
  PRIMARY KEY (`id`),
  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla de Reseñas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `restaurant_id` INT NULL,
  `dish_id` INT NULL,
  `comentario` TEXT,
  `calificacion` INT NOT NULL CHECK (`calificacion` BETWEEN 1 AND 5), -- Calificación de 1 a 5
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`dish_id`) REFERENCES `dish`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabla de Carritos de Compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Relación Carrito-Producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cart_product` (
  `cart_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `cantidad` INT DEFAULT 1,
  PRIMARY KEY (`cart_id`, `product_id`),
  FOREIGN KEY (`cart_id`) REFERENCES `cart`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `dish`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB;

ALTER TABLE `restaurant`
ADD COLUMN `tipo_comida` VARCHAR(50) NOT NULL AFTER `direccion`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
