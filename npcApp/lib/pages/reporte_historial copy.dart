// ignore_for_file: unused_import, depend_on_referenced_packages, list_remove_unrelated_type

import 'dart:io';
import 'package:crudfirebase/modelos/historial.model.dart';
import 'package:crudfirebase/peticiones/historial.peticion.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../prividers/tareas_firebas.dart';

List<Map<String, dynamic>> historial = [];

class ReporteHistorial1 extends StatefulWidget {
  @override
  State<ReporteHistorial1> createState() => _ReporteHistorial1State();
}

late DateTime _dateInicio, _dateFin;
String _fechaInicio = '', _fechaFin = "";

class _ReporteHistorial1State extends State<ReporteHistorial1> {
  _exportExel() async {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];
    sheet!.setColWidth(2, 50);
    sheet.setColAutoFit(3);
    /*  DateTime? fecha_1 =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(_dateInicio));
    DateTime fecha_2 =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(_dateFin)); */

    DateTime? fecha_1 = DateTime.parse('2022-08-09');

    DateTime fecha_2 = DateTime.parse('2022-08-11');

    List<pHistorial> h = [];
    listHistorial().then((his) async {
      h.addAll(his);

      h.removeWhere((item) =>
          DateTime.parse(item.date).isBefore(fecha_1) ||
          DateTime.parse(item.date).isAfter(fecha_2));
      h.sort((a, b) => a.date.compareTo(b.date));

      Map<String, dynamic> addList = {};
      List<Map<String, dynamic>> ordenarList = [];

      for (var order in h) {
        addList = {
          "nombre": order.name,
          "cliente": order.client,
          "code": order.code,
          "fecha": order.date,
          "estado": order.state,
          "cantidad": order.amount,
        };

        ordenarList.add(addList);

        print(addList);

        
 for (int i = 0; i < ordenarList.length; i++) {
      for (int j = 0; j < 6; j++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 0))
            .value = ordenarList[i].keys.elementAt(j);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
            .value = ordenarList[i].values.elementAt(j);
      }
    }
    final directory = await getApplicationDocumentsDirectory();

    excel.save();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd-kk-mm').format(now);
    String formattedDateMes = DateFormat('yyyy-MM').format(now);
    excel.save();

    String filePath =
        '${directory.path}/NPC HISTORIAL/$formattedDateMes/${formattedDate}H.xlsx';
    File(join(filePath))
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    setState(() {
      _fechaFin = '';
      _fechaInicio = '';
    });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 52, 240),
        title: const Center(
          child: Text(
            'Generar reporte del Historial',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: FutureBuilder(
        future: HistorialProductos().Historial,
        builder: (BuildContext contexto, AsyncSnapshot respuesta) {
          if (respuesta.hasData) {
            historial = respuesta.data;
            return historial.isNotEmpty
                ? Center(
                    child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/eHISTORIAL.png',
                            width: 400,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 20),
                          width: double.infinity,
                          child: RaisedButton(
                              padding: const EdgeInsets.all(20),
                              color: Color.fromARGB(255, 31, 52, 240),
                              onPressed: () async {
                                _dateInicio = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime.now(),
                                ))!;

                                setState(() {
                                  _fechaInicio = DateFormat('yy-MM-dd')
                                      .format(_dateInicio);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: (_fechaInicio != "")
                                  ? Text(
                                      'Fecha inicio: $_fechaInicio',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )
                                  : const Text('Seleccionar fecha inicio',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ))),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 20),
                          width: double.infinity,
                          child: RaisedButton(
                              padding: const EdgeInsets.all(20),
                              color: Color.fromARGB(255, 31, 52, 240),
                              onPressed: () async {
                                _dateFin = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2030),
                                ))!;

                                setState(() {
                                  _fechaFin =
                                      DateFormat('yy-MM-dd').format(_dateFin);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: (_fechaFin != "")
                                  ? Text('Fecha fin: $_fechaFin',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 25))
                                  : const Text('Seleccionar fecha fin',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25))),
                        ),
                        (_fechaFin != "" && _fechaInicio != "")
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50, bottom: 20),
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(20),
                                  color: Color.fromARGB(255, 31, 52, 240),
                                  onPressed: () => _exportExel(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: const Text(
                                    'Descargar',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.pending_rounded,
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ))
                : const Center(
                    child: Text("No hay productos"),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
