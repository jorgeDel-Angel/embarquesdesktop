const { Router } = require('express');
const { consultarhistorials, agregarhistorials, modificarhistorial, eliminarhistorial} = require('../controllers/historial.controller')
const router = Router();


router.get('/api/historials', consultarhistorials);
router.post('/api/historials/registro', agregarhistorials);
router.put('/api/historials/modificar', modificarhistorial);
router.delete('/api/historials/eliminar/:id', eliminarhistorial);



module.exports = router;