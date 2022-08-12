import 'dart:convert';
import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modelos/producto.model.dart';

Future<List<Productos>> listProduct() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.8:4000/api/productos'));

  return compute(goToList, response.body);
}

List<Productos> goToList(String responseBody) {
  final pasar = json.decode(responseBody);

  return pasar['productos']
      .map<Productos>((json) => Productos.fromJson(json))
      .toList();
}

mapProductos(Productos product, bool mapId) {
  Map data;
  if (mapId) {
    data = {
      '_id': '${product.id}',
      'nombre': '${product.name}',
      'code': '${product.code}',
      'cantidad': '${product.amount}',
      'posicion': '${product.position}',
      'fecha': '${product.date}',
      'cliente': '${product.client}',
    };
  } else {
    data = {
      'nombre': '${product.name}',
      'code': '${product.code}',
      'cantidad': '${product.amount}',
      'posicion': '${product.position}',
      'fecha': '${product.date}',
      'cliente': '${product.client}',
    };
  }

  return data;
}

Future<Productos> addProducto(Productos product) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/productos/registro');

  var body = json.encode(mapProductos(product, false));

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);

  if (response.statusCode == 200) {
    return Productos.fromJson(jsonDecode(response.body)['producto']);
  } else {
    throw Exception('Failed to load product');
  }
}

Future<Productos> deleteProduct(String clientId) async {
  final http.Response response = await http.delete(
    Uri.parse('http://192.168.0.8:4000/api/productos/eliminar/$clientId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Productos.fromJson(jsonDecode(response.body)['producto']);
  } else {
    throw Exception('Failed to Delete productos');
  }
}
  
Future<Productos> modifyProducts(Productos product) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/productos/modificar');

  var body = json.encode(mapProductos(product, true));

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);
  if (response.statusCode == 200) {
    return Productos.fromJson(jsonDecode(response.body)['producto']);
  } else {
    throw Exception('Failed to modify productos');
  }
}
