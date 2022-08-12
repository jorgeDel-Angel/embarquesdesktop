

const { Schema, model } = require('mongoose');
const historialSchema = new Schema({
    cantidad: String,
    cliente: String,
    code: String,
    estado: String,
    fecha: String,
    nombre: String,
    posicion: String,
})

module.exports = model('Historial', historialSchema);