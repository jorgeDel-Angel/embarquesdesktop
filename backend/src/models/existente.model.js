

const { Schema, model } = require('mongoose');
const existenteSchema = new Schema({

    code: String,
    grupo: String,
    nombre: String,
    total: String,

})

module.exports = model('Existente', existenteSchema);


