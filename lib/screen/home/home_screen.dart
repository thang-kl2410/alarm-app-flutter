import 'package:alarm_app/controller/alarm_controller.dart';
import 'package:alarm_app/helper/notification_helper.dart';
import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/screen/home/widget/alarm_item.dart';
import 'package:alarm_app/utils/time_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    isLoading.value = true;
    Get.find<AlarmController>().getAlarms().then((value){
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Thắng's alarm"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            onPressed: ()=> _showTimePicker(context, controller),
            child: const Icon(Icons.add, size: 32.0,),
          ),
          body: controller.alarms?.length == 0 ?
            const Center(
              child: Text('Bạn chưa đặt báo thức nào'),
            ) : SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 80.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.alarms?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index)
                  => AlarmItem(
                    alarm: controller.alarms![index],
                    onActive: (v)=> controller.changeStateAlarm(controller.alarms![index].id),
                    onDelete:()=> controller.deleteAlarms(controller.alarms![index].id),
                  )
              ),
            )
          ),
        ),
    );
  }

  Future<void> _showTimePicker(BuildContext context, AlarmController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      controller.createAlarm(
        AlarmModel(false, TimeConverter.timeToMinutes(selectedTime)), (){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thời gian này đã được thiết lập trước đó', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                backgroundColor: Colors.green,
              ),
            );
          }
      );
    }
  }
}
