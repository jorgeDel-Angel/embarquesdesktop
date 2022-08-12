

const { Schema, model } = require('mongoose');
const productoSchema = new Schema({
   
    fecha: date,
    cliente: String,
    nombre: String,
    code: String,
    cantidad: String,
    posicion: String,
    
})

module.exports = model('Producto', productoSchema);


