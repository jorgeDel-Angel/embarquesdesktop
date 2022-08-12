// ignore_for_file: use_key_in_widget_constructors, unused_field, depend_on_referenced_packages

import 'package:crudfirebase/modelos/existente.model.dart';
import 'package:crudfirebase/modelos/historial.model.dart';
import 'package:crudfirebase/modelos/producto.model.dart';

import 'package:crudfirebase/pages/text_box.dart';
import 'package:crudfirebase/peticiones/existente.peticion.dart';
import 'package:crudfirebase/peticiones/historial.peticion.dart';
import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmbarcarProduct extends StatefulWidget {
  final Productos _productos;
  EmbarcarProduct(this._productos);
  @override
  State<StatefulWidget> createState() => _EmbarcarProduct();
}

class _EmbarcarProduct extends State<EmbarcarProduct> {
//hitorial
  //List<Map<String, dynamic>> argumentData = Get.arguments;

  late TextEditingController controllerCode;
  late TextEditingController controllerGrupo;
  late TextEditingController controllerNombre;
  late TextEditingController controllerCantidad;
  late TextEditingController controllerTotal;

  late TextEditingController controllerEstado;
  late TextEditingController controllerPosicion;
  late String id;

  @override
  String t = '';
  void initState() {
    Productos p = widget._productos;

    DateTime now = DateTime.now();
    String fecha = DateFormat('yyyy-MM-dd').format(now);
    controllerCode = TextEditingController(text: p.code);
    controllerGrupo = TextEditingController(text: p.client);
    controllerNombre = TextEditingController(text: p.name);
    controllerCantidad = TextEditingController(text: p.amount);
    //controllerTotal = TextEditingController(text: p.);

    controllerEstado = TextEditingController()..text = 'salida';
    controllerPosicion = TextEditingController(text: p.position);
    id = p.id;
    t = p.amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Embarcar Producto"),
        ),
        body: ListView(
          children: [
            TextBox(controllerCode, "Codigo",false),
            TextBox(controllerNombre, "Nombre",false),
            TextBox(controllerGrupo, "Cliente",false),
            //TextBox(controllerTotal, "Total en almacen"),
            TextBox(controllerCantidad, "Cantidad",false),
            ElevatedButton(
                onPressed: () {
                  String code = controllerCode.text;
                  String grupo = controllerGrupo.text;
                  String nombre = controllerNombre.text;
                  String cantidad = controllerCantidad.text;
                  DateTime now = DateTime.now();
                  String fecha = DateFormat('yyyy-MM-dd').format(now);
                  String estado = 'salida';
                  String posicion = '';

/////////

                  List<pHistorial> lHistorial = [];
                  List<Existentes> lExist = [];

                  listHistorial().then((value) {
                    lHistorial = value;
                    lHistorial.removeWhere((element) => element.code != code);

                    listExist().then((value1) {
                      lExist = value1;
                      lExist.removeWhere((element) => element.nombre != nombre);

                      String nTotal =
                          (int.parse(lExist[0].total) - int.parse(t))
                              .toString();

                      pHistorial h = pHistorial(
                          code: code,
                          name: nombre,
                          amount: cantidad,
                          client: grupo,
                          state: estado,
                          date: fecha,
                          position: posicion);

                      Existentes e = Existentes(
                          id: lExist[0].id,
                          code: lExist[0].code,
                          nombre: nombre,
                          total: nTotal,
                          grupo: grupo);

                      addpHistorial(h).then((historial) {
                        if (historial.id != '') {
                          // Navigator.pop(context, historial);}
                        }
                      });
                      deleteProduct(id).then((producto) {
                        if (producto.id != '') {}
                      });
                      modifyExistente(e).then((existentes) {
                        if (existentes.id != '') {
                          Navigator.pop(context, existentes);
                        }
                      });
                    });
                  });
/////////////

                  if (code.isNotEmpty &&
                      nombre.isNotEmpty &&
                      grupo.isNotEmpty &&
                      cantidad.isNotEmpty) {
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Favor de llenar todos los campos'),
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text("Eliminar Producto")),
          ],
        ));
  }
}
