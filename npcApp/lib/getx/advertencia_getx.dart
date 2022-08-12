import 'package:crudfirebase/getx/status_conexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crudfirebase/utils/check_internet.dart';
// import 'dart:async';



class WarningWidgetGetX extends StatelessWidget {
  const WarningWidgetGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConnetionStatusController());
    return Obx(() {
      return Visibility(
        visible: controller.status.value != ConnectionStatus.online,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          color: Color.fromARGB(255, 255, 0, 0),
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: const  [
              Icon(Icons.wifi_off, color: Colors.white),
              SizedBox(width: 8),
              Text(' Verifique su conexion a internet',style: TextStyle(color: Colors.white), ),
            ],
            ),
        )
      );
    });
  }
}
