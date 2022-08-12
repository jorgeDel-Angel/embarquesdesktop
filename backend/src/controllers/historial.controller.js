const historialService = require('../services/historial.service');

const agregarhistorials = async (req, res) => {
    console.log(req.body);
    res.json({
       historial: await historialService.guardarhistorial(req.body)

    })

}

const consultarhistorials = async(req, res) => {
    res.json({
        historials: await historialService.consultarhistorials()
    })
}

const modificarhistorial = async(req, res) => {
    res.json({
        historial: await historialService.modificarhistorial(req.body)
    })
}

const eliminarhistorial = async(req, res) => {
    res.json({
        historial: await historialService.eliminarhistorial(req.params.id)
    })
}



module.exports = {consultarhistorials, agregarhistorials, modificarhistorial, eliminarhistorial};