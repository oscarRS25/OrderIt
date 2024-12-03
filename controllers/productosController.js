const connection = require('../db/connection');

// Añadir producto
const addProducto = (req, res) => {
  const { id_restaurante, nombre, descripcion, precio, categoria } = req.body;

  const query = `INSERT INTO Productos (id_restaurante, nombre, descripcion, precio, categoria) VALUES (?, ?, ?, ?, ?)`;
  connection.query(query, [id_restaurante, nombre, descripcion, precio, categoria], (error, results) => {
    if (error) {
      return res.status(500).json({ error: 'Error al añadir producto' });
    }
    res.status(201).json({ message: 'Producto añadido exitosamente', id: results.insertId });
  });
};

// Editar producto
const updateProducto = (req, res) => {
  const { id_producto, nombre, descripcion, precio, categoria } = req.body;

  const query = `UPDATE Productos SET nombre = ?, descripcion = ?, precio = ?, categoria = ? WHERE id_producto = ?`;
  connection.query(query, [nombre, descripcion, precio, categoria, id_producto], (error) => {
    if (error) {
      return res.status(500).json({ error: 'Error al actualizar producto' });
    }
    res.json({ message: 'Producto actualizado exitosamente' });
  });
};

// Eliminar producto
const deleteProducto = (req, res) => {
  const { id_producto } = req.body;

  const query = `DELETE FROM Productos WHERE id_producto = ?`;
  connection.query(query, [id_producto], (error) => {
    if (error) {
      return res.status(500).json({ error: 'Error al eliminar producto' });
    }
    res.json({ message: 'Producto eliminado exitosamente' });
  });
};

// Ver producto
const getProductos = (req, res) => {
    const { id_restaurante } = req.query; 

    let query = 'SELECT * FROM Productos';
    let queryParams = [];

    if (id_restaurante) {
      query += ' WHERE id_restaurante = ?';
      queryParams.push(id_restaurante);
    }
  
    connection.query(query, queryParams, (error, results) => {
      if (error) {
        return res.status(500).json({ error: 'Error al obtener productos' });
      }
      res.json(results);
    });
  };
  
module.exports = { addProducto, updateProducto, deleteProducto, getProductos };
  

