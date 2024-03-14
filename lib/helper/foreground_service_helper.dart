import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';

class ForegroundServiceHelper {
  void startForegroundService(Function() handleStart) async {
    ForegroundServiceHandler.notification.setTitle('Báo thức');
    ForegroundServiceHandler.notification.setText('Có báo thức đang chờ');
    ForegroundService().start();
    debugPrint("Started service");
    handleStart();
  }

  void stopForeground(){
    ForegroundService().stop();
  }
}
