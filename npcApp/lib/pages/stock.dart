import 'dart:core';
//import 'package:crudfirebase/pages/formulario.dart';
//import 'package:crudfirebase/pages/agregar.dart';
import 'package:crudfirebase/pages/reporte_historial.dart';
import 'package:crudfirebase/prividers/tareas_firebas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../getx/advertencia_getx.dart';
//import 'select_report.dart';

Map<String, dynamic> temporalData = {};

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  static const nombrePagina = "stock";

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  String _scanBarcode = '';

  Map<String, dynamic> ScanCode = {};
  //code

  List<Map<String, dynamic>> tareas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: SearchP());
            },
          )
        ],
        title: const Center(
          child: Text(
            'Productos en Stock',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          const WarningWidgetGetX(),
          Expanded(
            child: FutureBuilder(
              future: ProductosExistentes().existentes,
              builder: (BuildContext contexto, AsyncSnapshot respuesta) {
                if (respuesta.hasData) {
                  listaActual = respuesta.data;

                  listaActual.removeWhere((item) => item['total'] == 0);
                  return listaActual.isNotEmpty
                      ? ListView.builder(
                          itemCount: listaActual.length,
                          itemBuilder: (context, index) {
                            List<Widget> temporal = [];

                            return ListTile(
                                leading: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://images.vexels.com/media/users/3/146551/isolated/lists/2f475b1c7161650fade2470e02b3f816-caja-cuadrada-con-carteles.png')),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          listaActual[index]['code'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    const Text('Total en Almacen'),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          listaActual[index]['nombre'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      listaActual[index]['total'].toString(),
                                    ),
                                  ],
                                ));
                          })
                      : const Center(
                          child: Text("No hay material en almacen"),
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> listaActual = [];

class SearchP extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, listaActual);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _flitro = listaActual.where((element) {
      return element['nombre']
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _flitro.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.vexels.com/media/users/3/146551/isolated/lists/2f475b1c7161650fade2470e02b3f816-caja-cuadrada-con-carteles.png')),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        _flitro[index]['code'],
                        textAlign: TextAlign.left,
                      ),
                      //const Text('Posición')
                    ],
                  ),
                  const Text('Total en Almacen'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _flitro[index]['nombre'],
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _flitro[index]['total'].toString(),
                  ),
                ],
              ));
        });
  }

  List<Map<String, dynamic>> _flitro = [];
  @override
  Widget buildSuggestions(BuildContext context) {
    _flitro = listaActual.where((element) {
      return element['nombre']
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _flitro.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.vexels.com/media/users/3/146551/isolated/lists/2f475b1c7161650fade2470e02b3f816-caja-cuadrada-con-carteles.png')),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        _flitro[index]['code'],
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Text('Total en Almacen'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _flitro[index]['nombre'],
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _flitro[index]['total'].toString(),
                  ),
                ],
              ));
        });
  }
}
