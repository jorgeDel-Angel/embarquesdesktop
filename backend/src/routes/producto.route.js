const { Router } = require('express');
const { consultarproductos, agregarproductos, modificarproducto, eliminarproducto} = require('../controllers/producto.controller')
const router = Router();


router.get('/api/productos', consultarproductos);
router.post('/api/productos/registro', agregarproductos);
router.put('/api/productos/modificar', modificarproducto);
router.delete('/api/productos/eliminar/:id', eliminarproducto);



module.exports = router;