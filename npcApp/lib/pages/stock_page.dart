import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/pages/message_response.dart';
import 'package:crudfirebase/pages/modify_product.dart';
import 'package:crudfirebase/pages/register_product.dart';
import 'package:crudfirebase/pages/reporte_historial%20copy.dart';
import 'package:crudfirebase/pages/search_stock.dart';
import 'package:intl/intl.dart';
import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../modelos/existente.model.dart';
import '../modelos/historial.model.dart';
import '../peticiones/existente.peticion.dart';
import '../peticiones/historial.peticion.dart';
import 'reporte_historial.dart';
import 'reporte_stock.dart';

class StockPage extends StatefulWidget {
  final String _title;
  StockPage(this._title);
  @override
  State<StatefulWidget> createState() => _StockPage();
}

class _StockPage extends State<StockPage> {
//
  String _scanBarcode = '';

//

  var code;
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Get.to(() => ReporteHistorial1());
      }
      if (index == 1) {
        Get.to(() => ReporteStock());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 52, 240),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                List<Existentes> _h = <Existentes>[];
                List<Existentes> h = <Existentes>[];
                listExist().then((value) {
                  _h.addAll(value);
                });
                // _h.removeWhere((element) => element.state != 'entrada');
                showSearch(context: context, delegate: SearchExistentes(_h));
              },
            )
          ],
          title: Text(
            widget._title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: getHistorial(context, listExist()),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Color.fromARGB(255, 31, 52, 240),
            selectedIconTheme:
                const IconThemeData(color: Color.fromARGB(255, 31, 52, 240)),
            selectedItemColor: Color.fromARGB(255, 31, 52, 240),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: 'Desacargar Historial',
              ),
              BottomNavigationBarItem(
                //nselectedItemColor: Colors.deepOrangeAccent,
                icon: Icon(
                  Icons.download,
                ),

                label: 'Descargar Stock',
              ),
            ],
            onTap: _onItemTapped));
  }

  Widget getHistorial(
      BuildContext context, Future<List<Existentes>> futureHistorial) {
    return FutureBuilder(
      future: futureHistorial,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el cargando...
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
            // print(snapshot.data);
            return snapshot.data != null
                ? existentesList(snapshot.data)
                : Container(
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text('Sin Datos'),
                    ),
                  );
          default:
            return const Text('Recarga la pantalla....!');
        }
      },
    );
  }

  Widget existentesList(List<Existentes> Existentes) {
    return ListView.builder(
      itemCount: Existentes.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/box.png')),
            onLongPress: () {
              // removeClient(context, Existentess[index]);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      Existentes[index].code,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                const Text('Cliente'),
              ],
            ),

            // title: Text(Existentes[index].nombre+ " " + Existentes[index].code),
            // subtitle: Text(Existentes[index].total),

//
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      Existentes[index].nombre,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      Existentes[index].total,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  Existentes[index].grupo,
                ),
              ],
            ));
//
      },
    );
  }
}
