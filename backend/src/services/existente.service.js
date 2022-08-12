const existentemodel = require('../models/existente.model');

class ExistenteService {
    ExistenteService() {}

    async guardarexistente(existente = new existentemodel()) {
        try {
            var existenteGuardado;
            await existentemodel.create(existente).then( (value) => {
                existenteGuardado =  value;
            });

            return existenteGuardado;

        } catch (error) {
            console.log(error);

        }
    }

    async consultarexistentes() {
        try {

            return await existentemodel.find();
        } catch (error) {
            return error;

        }
    }

    async eliminarexistente(idc) {
        console.log(idc);
        var existenteeliminado;
        try {
            await existentemodel.findOneAndRemove({
                _id: idc
            }).then( (value) => {
                console.log(value);
                existenteeliminado = value;
            });

            return existenteeliminado;
        } catch (error) {
            console.log(error);

        }
    }

    async modificarexistente(existentemod) {

        var existentemodificado;
        try {
            await existentemodel.findOneAndUpdate({
                _id: existentemod._id
            }, existentemod).then( (value) => {

                existentemodificado = existentemod;
            });

            return existentemodificado;
        } catch (error) {
            console.log(error);

        }
    }
}

module.exports = new ExistenteService();

