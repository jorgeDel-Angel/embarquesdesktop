// import 'dart:convert';
// import 'package:crudfirebase/models/models.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// class ProductosServices extends ChangeNotifier{
//   final String _urlBase = 'prueba-6f068-default-rtdb.firebaseio.com';

//   final List<Productos> listaPoductos = [];
  
//   ProductosServices(){
//     cargarProductos();
//   }


//   Future<List<Productos>> cargarProductos() async{
//     final url = Uri.https(_urlBase, 'tareas.json');
//     final respuesta = await http.get(url);


//     final Map<String, dynamic> obj = json.decode(respuesta.body);

//     obj.forEach((key, value) {
//       final prodcuto= Productos.fromMap(value);
//       prodcuto.id= key;
//       listaPoductos.add(prodcuto);

//     });
//     print(listaPoductos);
//     return listaPoductos;
//   }
// }