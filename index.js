const express = require('express');
const app = express();

const pedidosRoutes = require('./routes/pedidos');

app.use(express.json());

// Rutas principales
app.use('/api/pedidos', pedidosRoutes);


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
