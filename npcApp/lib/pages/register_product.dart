// ignore_for_file: use_key_in_widget_constructors, unused_field, depend_on_referenced_packages

import 'package:crudfirebase/modelos/existente.model.dart';
import 'package:crudfirebase/modelos/historial.model.dart';
import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/pages/entrada_page.dart';
import 'package:crudfirebase/pages/text_box.dart';
import 'package:crudfirebase/peticiones/existente.peticion.dart';
import 'package:crudfirebase/peticiones/historial.peticion.dart';
import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrarProducto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrarProducto();
}

class _RegistrarProducto extends State<RegistrarProducto> {
//hitorial
  List<Map<String, dynamic>> argumentData = Get.arguments;

  late TextEditingController controllerCode;
  late TextEditingController controllerGrupo;
  late TextEditingController controllerNombre;
  late TextEditingController controllerCantidad;
  late TextEditingController controllerTotal;
  late TextEditingController controllerFecha;
  late TextEditingController controllerEstado;
  late TextEditingController controllerPosicion;
  late String id;

  @override
  void initState() {
    Existentes ex;

    controllerCode = TextEditingController()..text = argumentData[2]['code'];
    controllerGrupo = TextEditingController()..text = argumentData[5]['grupo'];
    controllerNombre = TextEditingController()
      ..text = argumentData[1]['nombre'];
    controllerCantidad = TextEditingController();
    controllerTotal = TextEditingController()..text = argumentData[4]['total'];
    controllerFecha = TextEditingController();
    controllerEstado = TextEditingController();
    controllerPosicion = TextEditingController();
    id = argumentData[7]['id'];
    print("este es el primer id: $id, ${id.runtimeType}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registrar Producto"),
        ),
        body: ListView(
          children: [
            TextBox(controllerCode, "Codigo", false,),
            TextBox(controllerNombre, "Nombre", false,),
            TextBox(controllerGrupo, "Cliente", false,),
            TextBox(controllerTotal, "Total en almacen", false,),
            TextBox(controllerCantidad, "Cantidad", true,),
            ElevatedButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  String code = controllerCode.text;
                  String grupo = controllerGrupo.text;
                  String nombre = controllerNombre.text;
                  String cantidad = controllerCantidad.text;
                  String total = controllerTotal.text;
                  String fecha = DateFormat('yyyy-MM-dd').format(now);
                  String estado = 'entrada';
                  String posicion = 'recibo';
                  String id = '';

                  if (code.isNotEmpty &&
                      nombre.isNotEmpty &&
                      grupo.isNotEmpty &&
                      total.isNotEmpty &&
                      cantidad.isNotEmpty) {
                    pHistorial h = pHistorial(
                        code: code,
                        name: nombre,
                        amount: cantidad,
                        client: grupo,
                        state: estado,
                        date: fecha,
                        position: posicion);

                    Productos p = Productos(
                        code: code,
                        name: nombre,
                        amount: cantidad,
                        position: posicion,
                        date: fecha,
                        client: grupo);
                    String totala = (int.parse(argumentData[4]['total']) +
                            int.parse(cantidad))
                        .toString();

                    Existentes e = Existentes(
                        id: argumentData[7]['id'],
                        code: argumentData[8]['oCode'],
                        nombre: nombre,
                        total: totala,
                        grupo: grupo);

                    addProducto(p).then((productos) {
                      if (productos.id != '') {
                        // Navigator.pop(context, productos);
                      }

                      addpHistorial(h).then((historial) {
                        if (historial.id != '') {
                          // Navigator.pop(context, historial);
                          modifyExistente(e).then((existente) {
                            if (existente.id != '') {
                              Navigator.pop(context, historial);
                            }
                          });
                        }
                      });
                    });
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
                child: const Text("Guardar Contacto")),
          ],
        ));
  }
}
