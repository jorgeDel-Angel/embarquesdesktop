import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../prividers/tareas_firebas.dart';

List<Map<String, dynamic>> stock = [];

class ReporteStock extends StatefulWidget {
  @override
  State<ReporteStock> createState() => _ReporteStockState();
}

late DateTime _dateInicio, _dateFin;
String _fechaInicio = '', _fechaFin = "";

class _ReporteStockState extends State<ReporteStock> {
  _exportExel() async {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];
    sheet!.setColWidth(2, 50);
    sheet.setColAutoFit(3);

    for (var item in stock) {
      item.keys
          .where((k) => item[k] == 'id') // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(item.remove); // remove selected keys
    }

    for (var item in stock) {
      item.removeWhere((key, value) => key == 'id');
    }

    for (int i = 0; i < stock.length; i++) {
      for (int j = 0; j < 4; j++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 0))
            .value = stock[i].keys.elementAt(j);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
            .value = stock[i].values.elementAt(j);
      }
    }

    final directory = await getApplicationDocumentsDirectory();

    excel.save();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd-kk-mm').format(now);
    String formattedDateMes = DateFormat('yyyy-MM').format(now);
    excel.save();

    String filePath =
        '${directory.path}/NPC STOCK/$formattedDateMes/${formattedDate}S.xlsx';
    File(join(filePath))
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    setState(() {
      _fechaFin = '';
      _fechaInicio = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 52, 240),
        title: const Center(
          child: Text(
            'Generar reporte de Stock',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ProductosExistentes().existentes,
        builder: (BuildContext contexto, AsyncSnapshot respuesta) {
          if (respuesta.hasData) {
            stock = respuesta.data;
            return stock.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
                          alignment: Alignment.center,
                          child: Image.asset('assets/stock.png', width: 400),
                        ),
                        ElevatedButton(
                            onPressed: () => _exportExel(),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 31, 52, 240),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('Descargar Reporte de Stock',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ))),
                        const Icon(
                          Icons.pending_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
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