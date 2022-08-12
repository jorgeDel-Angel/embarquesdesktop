const ProductoService = require('../services/producto.service');


const agregarproductos = async (req, res) => {
    console.log(req.body);
    res.json({
       producto: await ProductoService.guardarproducto(req.body)

    })

}

const consultarproductos = async(req, res) => {
    res.json({
        productos: await ProductoService.consultarproductos()
    })
}

const modificarproducto = async(req, res) => {
    res.json({
        producto: await ProductoService.modificarproducto(req.body)
    })
}

const eliminarproducto = async(req, res) => {
    res.json({
        producto: await ProductoService.eliminarproducto(req.params.id)
    })
}



module.exports = {consultarproductos, agregarproductos, modificarproducto, eliminarproducto};