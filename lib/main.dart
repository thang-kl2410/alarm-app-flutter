import 'package:alarm_app/helper/foreground_service_helper.dart';
import 'package:alarm_app/helper/notification_helper.dart';
import 'package:alarm_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/get_di.dart' as di;
import 'package:workmanager/workmanager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper().initial();
  await Permission.notification.request();
  Workmanager().initialize(callbackDispatcher);
  await di.init();
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    );
  }
}