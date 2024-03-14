import 'package:alarm_app/controller/alarm_controller.dart';
import 'package:alarm_app/database/alarm_dao.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

import '../objectbox.g.dart';


Future<void> init () async {
  final directory = await getApplicationDocumentsDirectory();
  final store = Store(getObjectBoxModel(), directory: directory.path + '/objectbox');

  Get.put(store);
  Get.lazyPut(() => AlarmDao(Get.find()));
  Get.lazyPut(() => AlarmController(Get.find()));
}