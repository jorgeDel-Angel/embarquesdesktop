import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/pages/message_response.dart';
import 'package:crudfirebase/pages/modify_product.dart';
import 'package:crudfirebase/pages/register_product.dart';
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
import 'embarcar_parcial.dart';
import 'embarcar_product.dart';
import 'search_entrada.dart';

class SalidaPage extends StatefulWidget {
  final String _title;
  SalidaPage(this._title);
  @override
  State<StatefulWidget> createState() => _SalidaPage();
}

class _SalidaPage extends State<SalidaPage> {
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
      List<pHistorial> lHistorial = [];
      List<Existentes> lExist = [];

      switch (index) {
        case 0:
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
                  :
                  //historial

                  print(lProducts[0].code);
              Get.to(
                () => EmbarcarProduct(lProducts[0]),
              )!
                  .then((newContact) {
                setState(() {
                  messageResponse(
                      context, newContact.code + " a sido eliminado...!");
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
                  : Get.to(() => EmbarcarParcial(lProducts[0]))!
                      .then((newContact) {
                      setState(() {
                        messageResponse(context,
                            newContact.code + " a quedado parcial...!");
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
                  _h.removeWhere((element) => element.state == 'entrada');
                });
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
       

        /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterContact()))
              .then((newContact) {  
            setState(() {
              messageResponse(
                  context, newContact.nombre + " a sido guardado...!");
            });
          });
        },
        tooltip: "Agregar Contacto",
        child: Icon(Icons.add),
      ),*/
        );
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
        (element) => element.state == 'entrada' || element.date != fecha);
    return ListView.builder(
      itemCount: Historial.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/box.png')),
            onLongPress: () {},
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

            // title: Text(Historial[index].nombre+ " " + Historial[index].code),
            // subtitle: Text(Historial[index].total),

//
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
