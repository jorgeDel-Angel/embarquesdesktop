const historialmodel = require('../models/historial.model');

class HistorialService {
    HistorialService() {}

    async guardarhistorial(historial = new historialmodel()) {
        try {
            var historialGuardado;
            await historialmodel.create(historial).then( (value) => {
                historialGuardado =  value;
            });

            return historialGuardado;

        } catch (error) {
            console.log(error);

        }
    }

    async consultarhistorials() {
        try {

            return await historialmodel.find();
        } catch (error) {
            return error;

        }
    }

    async eliminarhistorial(idc) {
        console.log(idc);
        var historialEliminado;
        try {
            await historialmodel.findOneAndRemove({
                _id: idc
            }).then( (value) => {
                console.log(value);
                historialEliminado = value;
            });

            return historialEliminado;
        } catch (error) {
            console.log(error);

        }
    }

    async modificarhistorial(historialmod) {

        var historialModificado;
        try {
            await historialmodel.findOneAndUpdate({
                _id: historialmod._id
            }, historialmod).then( (value) => {

                historialModificado = historialmod;
            });

            return historialModificado;
        } catch (error) {
            console.log(error);

        }
    }
}

module.exports = new HistorialService();
