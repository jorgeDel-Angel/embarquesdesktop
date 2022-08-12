

import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

class BarCodeController extends GetxController {
  String valorCodigoBarras = '';
  Future<void> escanearCodigoBarras() async {
     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff0666', 'cancelar', true, ScanMode.BARCODE);



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
       valorCodigoBarras = 'barcodeScanRes';
       List<Map<String, dynamic>> deleteP = [];
       print('ddddddddddddddddddddddddd');
       print('ddddddddddddddddddddddddd');
       var vEliminar = Get.parameters;
       print("${vEliminar[0]}");

         int  contador = 0;
        /* for (int i = 0; i < tareas.length; i++) {

           if (tareas[i]['code'] == _scanBarcode) {
             contador= i;


             Get.to(() => FormularioPage(), arguments: [
               {"eliminar": 'First data'},
               {"second": 'Second data'}
             ]);
           }

         }*/
       print('aaaaaaaaaaaaaaaaaaa');
       Get.back;

     }


    valorCodigoBarras = 'barcodeScanRes';
    print('ddddddddddddddddddddddddd');
    print(valorCodigoBarras);
    update();
  }
}
