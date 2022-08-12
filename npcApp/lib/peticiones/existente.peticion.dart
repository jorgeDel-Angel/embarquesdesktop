import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modelos/existente.model.dart';

Future<List<Existentes>> listExist() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.8:4000/api/existentes'));

  return compute(goToList, response.body);
}

List<Existentes> goToList(String responseBody) {
  final pasar = json.decode(responseBody);  

  return pasar['existentes']
      .map<Existentes>((json) => Existentes.fromJson(json))
      .toList();
}

mapExistente(Existentes exist, bool mapId) {
  Map data;
  if (mapId) {
    data = {
      '_id': '${exist.id}',
      'code': '${exist.code}',
      'grupo': '${exist.grupo}',
      'nombre': '${exist.nombre}',
      'total': '${exist.total}',
    };
  } else {
    data = {
      'code': '${exist.code}',
      'grupo': '${exist.grupo}',
      'nombre': '${exist.nombre}',
      'total': '${exist.total}',
    };
  }

  return data;
}

Future<Existentes> addExistente(Existentes exist) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/existentes/registro');

  var body = json.encode(mapExistente(exist, false));

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);

  if (response.statusCode == 200) {
    return Existentes.fromJson(jsonDecode(response.body)['existente']);
  } else {
    throw Exception('Failed to load exist');
  }
}

Future<Existentes> deleteExistente(String clientId) async {
  final http.Response response = await http.delete(
    Uri.parse('http://192.168.0.8:4000/api/existentes/eliminar/$clientId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Existentes.fromJson(jsonDecode(response.body)['existente']);
  } else {
    throw Exception('Failed to Delete existentes');
  }
}

Future<Existentes> modifyExistente(Existentes exist) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/existentes/modificar');

  var body = json.encode(mapExistente(exist, true));

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);
  if (response.statusCode == 200) {
    return Existentes.fromJson(jsonDecode(response.body)['existente']);
  } else {
    throw Exception('Failed to modify existentes');
  }
}


//////
