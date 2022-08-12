import 'dart:convert';

import 'package:crudfirebase/modelos/historial.model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FetchUserList {
  var data = [];
  List<pHistorial> results = [];
  String urlList = 'https://jsonplaceholder.typicode.com/users/';

  Future<List<pHistorial>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
      
        data = json.decode(response.body);
        results = data.map((e) => pHistorial.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.name!.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
Future<List<pHistorial>> listHistorial() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.8:4000/api/historials'));

  return compute(goToList, response.body);
}

List<pHistorial> goToList(String responseBody) {
  final pasar = json.decode(responseBody);

  return pasar['historials']
      .map<pHistorial>((json) => pHistorial.fromJson(json))
      .toList();
}

mappHistorial(pHistorial historialP, bool mapId) {
  Map data;
  if (mapId) {
    data = {

        '_id': '${historialP.id}',
        'cantidad': '${historialP.amount}',
        'cliente': '${historialP.client}',
        'code': '${historialP.code}',
        'estado': '${historialP.state}',
        'fecha': '${historialP.date}',
        'nombre': '${historialP.name}',
        'posicion': '${historialP.position}',


    };
  } else {
    data = {
      'cantidad': '${historialP.amount}',
        'cliente': '${historialP.client}',
        'code': '${historialP.code}',
        'estado': '${historialP.state}',
        'fecha': '${historialP.date}',
        'nombre': '${historialP.name}',
        'posicion': '${historialP.position}',
    };
  }

  return data;
}

Future<pHistorial> addpHistorial(pHistorial client) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/historials/registro');

  var body = json.encode(mappHistorial(client, false));

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);

  if (response.statusCode == 200) {
    return pHistorial.fromJson(jsonDecode(response.body)['historial']);
  } else {
    throw Exception('Failed to load client');
  }
}

Future<pHistorial> deletepHistorial(String clientId) async {
  final http.Response response = await http.delete(
    Uri.parse('http://192.168.0.8:4000/api/historials/eliminar/$clientId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },

    
  );

  if (response.statusCode == 200) {
    return pHistorial.fromJson(jsonDecode(response.body)['historial']);
  } else {
    throw Exception('Failed to Delete historial');
  }
}

Future<pHistorial> modifypHistorial(pHistorial client) async {
  var url = Uri.parse('http://192.168.0.8:4000/api/historials/modificar');

  var body = json.encode(mappHistorial(client, true));

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);
  if (response.statusCode == 200) {
    return pHistorial.fromJson(jsonDecode(response.body)['historial']);
  } else {
    throw Exception('Failed to modify historial');
  }


  
}
