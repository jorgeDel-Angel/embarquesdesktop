const { Router } = require('express');
const { consultarexistentes, agregarexistentes, modificarexistente, eliminarexistente} = require('../controllers/existente.controller')
const router = Router();


router.get('/api/existentes', consultarexistentes);
router.post('/api/existentes/registro', agregarexistentes);
router.put('/api/existentes/modificar', modificarexistente);
router.delete('/api/existentes/eliminar/:id', eliminarexistente);



module.exports = router;