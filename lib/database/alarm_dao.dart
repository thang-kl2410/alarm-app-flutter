import 'package:alarm_app/model/alarm_model.dart';
import 'package:objectbox/objectbox.dart';

class AlarmDao {
  final Store _store;
  late final Box<AlarmModel> _alarmBox;

  AlarmDao(this._store) {
    _alarmBox = _store.box();
  }

  Future<void> insertAlarm(AlarmModel alarm, Function() onError) async {
    try{
      _alarmBox.put(alarm);
    } catch(e){
      onError();
    }
  }

  Future<AlarmModel?> getAlarmByID(int id) async {
    var alarm = _alarmBox.get(id);
    return alarm;
  }

  Future<List<AlarmModel>> getAllAlarms() async {
    var alarms = _alarmBox.getAll();
    alarms.sort((a, b) => a.compareTo(b));
    return alarms;
  }

  Future<void> updateAlarm(AlarmModel alarm) async {
    _alarmBox.put(alarm, mode: PutMode.update);
  }

  Future<void> deleteAlarm(int id) async {
    _alarmBox.remove(id);
  }
}