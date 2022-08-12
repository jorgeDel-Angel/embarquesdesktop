import 'dart:async';
import 'package:crudfirebase/main.dart';
import 'package:crudfirebase/utils/check_internet.dart';
import 'package:get/get.dart';

class ConnetionStatusController extends GetxController {
  late StreamSubscription _connectionSubscription;

  final status = Rx<ConnectionStatus>(ConnectionStatus.online);

 /*  ConnetionStatusController() {
    _connectionSubscription = internetChecks
        .internetStatus()
        .listen((newStatus) => status.value = newStatus);
  } */

  // @override
  void  disponse() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
