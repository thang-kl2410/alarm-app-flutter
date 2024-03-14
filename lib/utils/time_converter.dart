import 'package:flutter/material.dart';

class TimeConverter {
  static int timeToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  static int timeWithSencondToSecond(DateTime time) {
    return time.hour * 3600 + time.minute * 60 + time.second;
  }

  static TimeOfDay minutesToTime(int minutes) {
    int hour = minutes ~/ 60;
    int minute = minutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String minutesToStringTime(int minutes) {
    int hour = minutes ~/ 60;
    int minute = minutes % 60;
    String h = hour >= 10 ? '$hour' : '0$hour';
    String m = minute >= 10 ? '$minute' : '0$minute';
    return '$h : $m';
  }
}