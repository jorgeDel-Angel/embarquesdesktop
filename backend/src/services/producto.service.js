const productosmodel = require('../models/producto.model');

class ProdcutosService {
    ProdcutosService() {}

    async guardarproducto(producto = new productosmodel()) {
        try {
            var productoGuardado;
            await productosmodel.create(producto).then( (value) => {
                productoGuardado =  value;
            });

            return productoGuardado;

        } catch (error) {
            console.log(error);

        }
    }

    async consultarproductos() {
        try {

            return await productosmodel.find();
        } catch (error) {
            return error;

        }
    }

    async eliminarproducto(idc) {
        console.log(idc);
        var productoeliminado;
        try {
            await productosmodel.findOneAndRemove({
                _id: idc
            }).then( (value) => {
                console.log(value);
                productoeliminado = value;
            });

            return productoeliminado;
        } catch (error) {
            console.log(error);

        }
    }

    async modificarproducto(productomod) {

        var productomodificado;
        try {
            await productosmodel.findOneAndUpdate({
                _id: productomod._id
            }, productomod).then( (value) => {

                productomodificado = productomod;
            });

            return productomodificado;
        } catch (error) {
            console.log(error);

        }
    }
}

module.exports = new ProdcutosService();

