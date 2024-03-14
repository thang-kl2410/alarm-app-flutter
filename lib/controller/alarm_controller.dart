import 'package:alarm_app/database/alarm_dao.dart';
import 'package:alarm_app/helper/foreground_service_helper.dart';
import 'package:alarm_app/helper/notification_helper.dart';
import 'package:alarm_app/utils/time_converter.dart';
import 'package:get/get.dart';
import 'package:alarm_app/model/alarm_model.dart';

class AlarmController extends GetxController implements GetxService {
  final AlarmDao alarmDao;
  AlarmController(this.alarmDao);

  List<AlarmModel>? _alarms;
  List<AlarmModel>? get alarms => _alarms;

  Future<void> createAlarm(AlarmModel alarm, Function() onError) async {
    alarmDao.insertAlarm(alarm, onError);
    getAlarms();
    update();
  }

  Future<void> getAlarms() async {
    _alarms = [];
    _alarms = await alarmDao.getAllAlarms();
    bool isStop = true;
    _alarms?.forEach((e) {
      if(e.isActive == true){
        isStop = false;
        return;
      }
    });
    if(isStop == true){
      ForegroundServiceHelper().stopForeground();
    }
    update();
  }

  Future<void> deleteAlarms(int id) async {
    alarmDao.deleteAlarm(id);
    getAlarms();
    update();
  }

  Future<void> updateAlarm(AlarmModel alarm) async {
    alarmDao.updateAlarm(alarm);
    getAlarms();
    update();
  }

  Future<void> changeStateAlarm(int id) async {
    AlarmModel? _alarm = await alarmDao.getAlarmByID(id);
    if(_alarm != null){
      AlarmModel alarm_ = AlarmModel.withId(id, !_alarm.isActive, _alarm.time);
      alarmDao.updateAlarm(alarm_);
      if(_alarm.isActive == false){
        DateTime now = DateTime.now();
        int minuteInt = TimeConverter.timeWithSencondToSecond(now);
        int minutesSet = _alarm.time * 60 - minuteInt;
        ForegroundServiceHelper().startForegroundService(() => scheduleAlarm(minutesSet, id),);
      }
      if(_alarm.isActive == true){
        cancelScheduleAlarm(id);
      }
      getAlarms();
    }
    update();
  }

  void cancelAlarm(int id) async {
    AlarmModel? _alarm = await alarmDao.getAlarmByID(id);
    if(_alarm != null){
      AlarmModel alarm_ = AlarmModel.withId(id, !_alarm.isActive, _alarm.time);
      alarmDao.updateAlarm(alarm_);
      getAlarms();
    }
    update();
  }
}