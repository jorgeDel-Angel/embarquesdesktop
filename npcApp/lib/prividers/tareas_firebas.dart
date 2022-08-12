import 'dart:convert';
import 'package:http/http.dart' as http;

class TareasFirebase {
  static final TareasFirebase _instancia = TareasFirebase._privado();
  TareasFirebase._privado();
  factory TareasFirebase() {
    return _instancia;
  }
  Future<List<Map<String, dynamic>>> get tareas async {
    List<Map<String, dynamic>> tareas = [];
    final respuesta = await http.get(Uri.parse(
        'https://npcim-2c825-default-rtdb.firebaseio.com/tareas.json'));
    {
      Map<String, dynamic> datos = json.decode(respuesta.body);
      datos.forEach((indice, contenido) {
        contenido['id'] = indice;
        tareas.add(contenido);

      });
    }
    return tareas;
  }
  Future<bool> agregarProducto(Map<String, dynamic> nuevoProducto) async {
    final respuesta = await http.post(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/tareas.json"),
        body: json.encode(nuevoProducto));
    return true;
  }
  Future<bool> editarProducto(Map<String, dynamic> nuevoProducto) async {
    final respuesta = await http.put(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/tareas/${nuevoProducto['id']}.json"),
        body: json.encode(nuevoProducto));
    return true;
  }
  Future<bool> eliminarProducto(Map<String, dynamic> producto) async {
    final respuesta = await http.delete(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/tareas/${producto['id']}.json"));
    return true;
  }
}
//PRODUCTOS END
//HISTORIAL
class HistorialProductos {
  static final HistorialProductos _instancia = HistorialProductos._privado();
  HistorialProductos._privado();
  factory HistorialProductos() {
    return _instancia;
  }
  Future<List<Map<String, dynamic>>> get Historial async {
    List<Map<String, dynamic>> Historial = [];
    final rHistorial = await http.get(Uri.parse(
        'https://npcim-2c825-default-rtdb.firebaseio.com/historial.json'));
    {
      Map<String, dynamic> datos = json.decode(rHistorial.body);
      datos.forEach((indice, contenido) {
        contenido['id'] = indice;
        Historial.add(contenido);
        
      });
    }
    return Historial;
    
  }
  Future<bool> agregarHistorial(Map<String, dynamic> nuevoProducto) async {
    final Historial= await http.post(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/historial.json"),
        body: json.encode(nuevoProducto));
    return true;
  }

  Future<bool> editarHistorial(Map<String, dynamic> nuevoProducto) async {
    final respuesta = await http.put(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/historial/${nuevoProducto['id']}.json"),
        body: json.encode(nuevoProducto));
    return true;
  }
  Future<bool> eliminarHistorial(Map<String, dynamic> producto) async {
    final respuesta = await http.delete(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/historial/${producto['id']}.json"));
    return true;
  }
}
//HISTORIAL END

//EXISTENTES
class ProductosExistentes {
  static final ProductosExistentes _instancia = ProductosExistentes._privado();
  ProductosExistentes._privado();
  factory ProductosExistentes() {
    return _instancia;
  }
  Future<List<Map<String, dynamic>>> get existentes async {
    List<Map<String, dynamic>> existentes = [];
    final respuesta = await http.get(Uri.parse(
        'https://npcim-2c825-default-rtdb.firebaseio.com/existentes.json'));
    {
      Map<String, dynamic> datos = json.decode(respuesta.body);
      datos.forEach((indice, contenido) {
        contenido['id'] = indice;
        existentes.add(contenido);
     
      });
 
    }
   
    return existentes;
  }
  Future<bool> editarProducto(Map<String, dynamic> nuevoProducto) async {
    final respuesta = await http.put(Uri.parse(
        "https://npcim-2c825-default-rtdb.firebaseio.com/existentes/${nuevoProducto['id']}.json"),
        body: json.encode(nuevoProducto));
    return true;
  }
}
//EXISTENTES END

