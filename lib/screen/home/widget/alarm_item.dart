import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/utils/time_converter.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatelessWidget {
  const AlarmItem({super.key, this.alarm, this.onActive, this.onDelete});
  final AlarmModel? alarm;
  final Function(bool)? onActive;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onDelete,
      child: Container(
        height: 64.0,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]
        ),
        child: Row(
          children: [
            Text(
              TimeConverter.minutesToStringTime(alarm!.time),
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0
              ),
            ),
            const Spacer(),
            Switch(
                value: alarm?.isActive ?? false,
                onChanged: onActive
            )
          ],
        ),
      ),
    );
  }
}
