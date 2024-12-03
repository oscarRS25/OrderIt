const connection = require('../db/connection');

// Crear pedido
const createPedido = (req, res) => {
  const { id_cliente, id_restaurante, productos } = req.body;

  const queryPedido = `INSERT INTO Pedidos (id_cliente, id_restaurante, fecha_pedido, estado_pedido) VALUES (?, ?, NOW(), 'pendiente')`;
  connection.query(queryPedido, [id_cliente, id_restaurante], (error, results) => {
    if (error) {
      return res.status(500).json({ error: 'Error al crear pedido' });
    }

    const id_pedido = results.insertId;
    const detalles = productos.map(({ id_producto, cantidad }) => [id_pedido, id_producto, cantidad]);
    const queryDetalles = `INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad) VALUES ?`;

    connection.query(queryDetalles, [detalles], (error) => {
      if (error) {
        return res.status(500).json({ error: 'Error al registrar detalles del pedido' });
      }
      res.status(201).json({ message: 'Pedido realizado exitosamente', id_pedido });
    });
  });
};

// Ver pedidos por restaurante
const getPedidosByRestaurante = (req, res) => {
  const { id_restaurante } = req.params;
  const query = `SELECT * FROM Pedidos WHERE id_restaurante = ?`;
  connection.query(query, [id_restaurante], (error, results) => {
    if (error) {
      return res.status(500).json({ error: 'Error al obtener pedidos' });
    }
    res.json(results);
  });
};

// Actualizar estado de un pedido
const updateEstadoPedido = (req, res) => {
  const { id_pedido, estado_pedido } = req.body;
  const query = `UPDATE Pedidos SET estado_pedido = ? WHERE id_pedido = ?`;
  connection.query(query, [estado_pedido, id_pedido], (error) => {
    if (error) {
      return res.status(500).json({ error: 'Error al actualizar estado del pedido' });
    }
    res.json({ message: 'Estado del pedido actualizado exitosamente' });
  });
};

module.exports = { createPedido, getPedidosByRestaurante, updateEstadoPedido };

  