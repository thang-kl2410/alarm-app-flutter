import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initial() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher(){
  Workmanager().executeTask((task, inputData){
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '123', '123',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    var iosPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosPlatformChannelSpecifics);
    NotificationHelper().flutterLocalNotificationsPlugin.show(
      0, 'Báo thức', 'Đã đến giờ!',
      platformChannelSpecifics,
    );
    scheduleAlarm(24*3600, inputData?['id']);
    return Future.value(true);
  });
}

void scheduleAlarm(int second, int id) {
  if(second < 0){
    Workmanager().registerOneOffTask(
      "alarm-$id", "simpleTask", inputData: {'id': id},
      initialDelay: Duration(seconds: (24*3600 - second)),
    );
  } else {
    Workmanager().registerOneOffTask(
      "alarm-$id", "simpleTask", inputData: {'id': id},
      initialDelay: Duration(seconds: second),
    );
  }
}

void cancelScheduleAlarm(int id) {
  Workmanager().cancelByUniqueName("alarm-$id");
}
