import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/pages/message_response.dart';
import 'package:crudfirebase/pages/modify_product.dart';

import 'package:crudfirebase/pages/register_product.dart';
import 'package:crudfirebase/pages/search_entrada.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:intl/intl.dart';
import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../modelos/existente.model.dart';
import '../modelos/historial.model.dart';
import '../peticiones/existente.peticion.dart';
import '../peticiones/historial.peticion.dart';

List<pHistorial> _historial = <pHistorial>[];
List<pHistorial> _historialDispay = <pHistorial>[];
var _flitro = [];

class EntradaPage extends StatefulWidget {
  final String _title;

  // ignore: use_key_in_widget_constructors
  const EntradaPage(this._title);
  @override
  State<StatefulWidget> createState() => _EntradaPage();
}

class _EntradaPage extends State<EntradaPage> {
  @override
  void initState() {
    setState(() {
      listHistorial().then((value) {
        _historial.addAll(value);
        _historialDispay = _historial;
      });
    });
    //super.dispose();
  }

//
  String _scanBarcode = '';

  Future<void> scanBarcodeNormal(int index) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed';
    }
    if (barcodeScanRes == '-1') {
      SnackBar(
        content: const Text('Ha cancelado'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
    } else {
      _scanBarcode = barcodeScanRes;

      List<Productos> lProducts = [];
      List<pHistorial> lHistoriala = [];
      List<Existentes> lExist = [];

      switch (index) {
        case 0:
          {
            listProduct().then((value) {
              lProducts = value;
              lProducts.removeWhere((element) => element.code != _scanBarcode);
              lProducts.isNotEmpty
                  ? showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            content: const Text(
                                "ERROR \n Este producto ya esta registrado<"),
                            actions: <Widget>[
                              CupertinoButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ))
                  :
                  //historial
                  setState(() async {
                      var Scan = _scanBarcode;
                      int p = Scan.indexOf('-');
                      String nCadena = '';
                      for (int i = 0; i < p; i++) {
                        nCadena = nCadena + Scan[i];
                      }
                      listExist().then((value) async {
                        setState(() {
                          lExist = value;
                        });
                        lExist
                            .removeWhere((element) => element.code != nCadena);
                        // print(lExist[0].code);

                        lExist.isNotEmpty
                            ? Get.to(() => RegistrarProducto(), arguments: [
                                {"op": 2}, //0
                                {"nombre": lExist[0].nombre}, //1
                                {"code": _scanBarcode}, //2
                                {"posicion": 'posicion'}, //3
                                {"total": lExist[0].total}, //04
                                {"grupo": lExist[0].grupo}, //5
                                {"estado": 'entrada'}, //6
                                {"id": lExist[0].id}, //7
                                {"oCode": nCadena}, //8
                                //print(lExist[0])
                              ])!
                                .then((newContact) {
                                setState(() {
                                  messageResponse(context,
                                      newContact.code + " a sido guardado...!");
                                });
                              })
                            : showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('¡-ERROR-!'),
                                    content: const Text(
                                        'Favor de escanear el codigo otra vez.\nEn caso de que sigua el error\nnotificar al los de Sistemas.'),
                                    actions: [
                                      TextButton(
                                        // isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Aceptar'),
                                      )
                                    ],
                                  );
                                });
                      });
                    });
            });

            break;
          }
        case 1:
          {
            listProduct().then((value) {
              lProducts = value;
              lProducts.removeWhere((element) => element.code != _scanBarcode);
              lProducts.isEmpty
                  ? showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            content: const Text(
                                "ERROR \n Este producto NO esta registrado<"),
                            actions: <Widget>[
                              CupertinoButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ))
                  : Get.to(() => ModifyProduct(lProducts[0]))!
                      .then((newContact) {
                      setState(() {
                        messageResponse(context,
                            newContact.code + " a sido modificado...!");
                      });
                    });

              //end historial
            });
          }
          break;

        default:
          {
            print("Invalid choice");
          }
          break;
      }
    }
  }

//

  var code;
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        scanBarcodeNormal(index);
      }
      if (index == 1) {
        scanBarcodeNormal(index);
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
                List<pHistorial> _h = <pHistorial>[];
                List<pHistorial> h = <pHistorial>[];
                listHistorial().then((value) {
                  _h.addAll(value);
                 _h.removeWhere((element) => element.state != 'entrada');
                }
              

                );
               // _h.removeWhere((element) => element.state != 'entrada');
                showSearch(context: context, delegate: SearchP(_h));
              },
            )
          ],
          title: Text(
            widget._title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: getHistorial(context, listHistorial()),
       /*  bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Color.fromARGB(255, 31, 52, 240),
             selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 31, 52, 240)),
             selectedItemColor: Color.fromARGB(255, 31, 52, 240),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_sharp),
                label: 'Agregar prodcuto',
              ),
              BottomNavigationBarItem(
                //nselectedItemColor: Colors.deepOrangeAccent,
                icon: Icon(
                  Icons.edit_note,
                ),

                label: 'Editar Producto',
              ),
            ], onTap: _onItemTapped) */);
  }

  Widget getHistorial(
      BuildContext context, Future<List<pHistorial>> futureHistorial) {
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
                ? historialList(snapshot.data)
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

  Widget historialList(List<pHistorial> Historial) {
    DateTime now = DateTime.now();
    String fecha = DateFormat('yyyy-MM-dd').format(now);
    Historial.removeWhere(
        (element) => element.state != 'entrada' || element.date != fecha);
    return ListView.builder(
      itemCount: Historial.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/box.png')),
            onLongPress: () {
              // removeClient(context, pHistorials[index]);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      Historial[index].code,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                const Text('Estado'),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      Historial[index].name,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      Historial[index].amount,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  Historial[index].state,
                ),
              ],
            ));
//
      },
    );
  }
}
