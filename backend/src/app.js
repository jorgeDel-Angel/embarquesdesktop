const express =  require('express');
const bodyParser = require('body-parser');
const app = express();

const morgan = require('morgan');
const cors = require('cors');

app.use(express.urlencoded({extended: true})); 
app.use(express.json());

app.use(morgan('dev'));
app.use(cors());
app.use(require('./routes/cliente.route'))
app.use(require('./routes/historial.route'))
app.use(require('./routes/producto.route'))
app.use(require('./routes/existente.route'))


module.exports = app;