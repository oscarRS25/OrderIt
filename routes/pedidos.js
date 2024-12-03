const express = require('express');
const { createPedido, getPedidosByRestaurante, updateEstadoPedido } = require('../controllers/pedidosController');
const router = express.Router();

router.post('/', createPedido); // Realizar un pedido
router.get('/restaurante/:id_restaurante', getPedidosByRestaurante); // Ver pedidos por restaurante
router.put('/estado', updateEstadoPedido); // Actualizar estado del pedido

module.exports = router;
