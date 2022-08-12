const ExistenteService = require('../services/existente.service');


const agregarexistentes = async (req, res) => {
    console.log(req.body);
    res.json({
       existente: await ExistenteService.guardarexistente(req.body)

    })

}

const consultarexistentes = async(req, res) => {
    res.json({
        existentes: await ExistenteService.consultarexistentes()
    })
}

const modificarexistente = async(req, res) => {
    res.json({
        existente: await ExistenteService.modificarexistente(req.body)
    })
}

const eliminarexistente = async(req, res) => {
    res.json({
        existente: await ExistenteService.eliminarexistente(req.params.id)
    })
}



module.exports = {consultarexistentes, agregarexistentes, modificarexistente, eliminarexistente};