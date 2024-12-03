const express = require('express');
const { addProducto, updateProducto, deleteProducto, getProductos } = require('../controllers/productosController');
const router = express.Router();


router.post('/', addProducto);
router.put('/', updateProducto);
router.delete('/', deleteProducto);
router.get('/', getProductos);

module.exports = router;
