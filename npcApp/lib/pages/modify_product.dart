import 'package:crudfirebase/modelos/cliente.model.dart';
import 'package:crudfirebase/modelos/existente.model.dart';
import 'package:crudfirebase/modelos/historial.model.dart';
import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/peticiones/cliente.peticion.dart';
import 'package:crudfirebase/peticiones/existente.peticion.dart';
import 'package:crudfirebase/peticiones/historial.peticion.dart';
import 'package:flutter/material.dart';
import 'package:crudfirebase/pages/text_box.dart';
import 'package:get/get.dart';

import '../peticiones/producto.peticion.dart';

class ModifyProduct extends StatefulWidget {
  final Productos _productos;
  ModifyProduct(this._productos);
  @override
  State<StatefulWidget> createState() => _ModifyProduct();
}

class _ModifyProduct extends State<ModifyProduct> {
  late TextEditingController controllerCode;
  late TextEditingController controllerPosicion;
  late TextEditingController controllerNombre;
  late TextEditingController controllerCantidad;
  late TextEditingController controllerFecha;
  late TextEditingController controllerCliente;

  late String id;

  @override
  String t = '';
  void initState() {
    Productos p = widget._productos;

    controllerNombre = TextEditingController(text: p.name);
    controllerCode = TextEditingController(text: p.code);
    controllerCantidad = TextEditingController(text: p.amount);
    controllerPosicion = TextEditingController(text: p.position);
    controllerFecha = TextEditingController(text: p.date);
    controllerCliente = TextEditingController(text: p.client);
    t = p.amount;
    id = p.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Producto"),
      ),
      body: ListView(
        children: [
          TextBox(
            controllerCode,
            "Codigo",false
          ),
          TextBox(
            controllerNombre,
            'Nombre',false
          ),
          TextBox(
            controllerCantidad,
            'Cantidad',true
          ),
          /* TextBox(
            controllerPosicion,
            'Posicion',
          ), */
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  // background color
                  primary: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle: const TextStyle(fontSize: 20),
                  minimumSize: const Size(100, 40)),
              child: const Text(
                'Cancelar',
              ),
            ),
            const SizedBox(height: 100, width: 100),
            ElevatedButton(
                onPressed: () {
                  String code = controllerCode.text;
                  String nombre = controllerNombre.text;
                  String amount = controllerCantidad.text;
                  String position = controllerPosicion.text;
                  String date = controllerFecha.text;
                  String client = controllerCliente.text;

                  if (code.isNotEmpty && nombre.isNotEmpty && amount.isNotEmpty
                      //position.isNotEmpty
                      ) {
                    List<pHistorial> lHistorial = [];
                    List<Existentes> lExist = [];
                    listHistorial().then((value) {
                      lHistorial = value;
                      lHistorial.removeWhere((element) => element.code != code);

                      listExist().then((value1) {
                        lExist = value1;
                        lExist
                            .removeWhere((element) => element.nombre != nombre);

                        String nTotal =
                            (int.parse(lExist[0].total) - int.parse(t))
                                .toString();
                        nTotal =
                            (int.parse(nTotal) + int.parse(amount)).toString();

                        Existentes e = Existentes(
                            id: lExist[0].id,
                            code: lExist[0].code,
                            nombre: nombre,
                            total: nTotal,
                            grupo: client);

                        Productos p = Productos(
                            code: code,
                            name: nombre,
                            amount: amount,
                            position: position,
                            date: date,
                            client: client,
                            id: id);

                        pHistorial h = pHistorial(
                          code: code,
                          name: nombre,
                          amount: amount,
                          position: position,
                          date: date,
                          client: client,
                          state: lHistorial[0].state,
                          id: lHistorial[0].id,
                        );

                        modifypHistorial(h).then((historial) {
                          if (historial.id != '') {}
                        });
                        modifyExistente(e).then((existentes) {
                          if (existentes.id != '') {}
                        });
                        modifyProducts(p).then((productos) {
                          if (productos.id != '') {
                            Navigator.pop(context, productos);
                          }
                        });
                      });
                    });
                  }
                },
                child: Text("Actualizar"))
          ]),
          Center(
            child: ElevatedButton(
              onPressed: () {
                String code = controllerCode.text;
                String nombre = controllerNombre.text;

                String client = controllerCliente.text;

                List<pHistorial> lHistorial = [];
                List<Existentes> lExist = [];

                listHistorial().then((value) {
                  lHistorial = value;
                  lHistorial.removeWhere((element) => element.code != code);

                  listExist().then((value1) {
                    lExist = value1;
                    lExist.removeWhere((element) => element.nombre != nombre);

                    String nTotal =
                        (int.parse(lExist[0].total) - int.parse(t)).toString();

                    Existentes e = Existentes(
                        id: lExist[0].id,
                        code: lExist[0].code,
                        nombre: nombre,
                        total: nTotal,
                        grupo: client);

                    deletepHistorial('${lHistorial[0].id}').then((historial) {
                      if (historial.id != '') {}
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
              },
              style: ElevatedButton.styleFrom(
                  // background color
                  primary: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle: const TextStyle(fontSize: 20),
                  minimumSize: const Size(100, 40)),
              child: const Text(
                'Eliminar',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
