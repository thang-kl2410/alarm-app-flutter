import 'package:objectbox/objectbox.dart';

@Entity()
class AlarmModel implements Comparable<AlarmModel>{
  @Id(assignable: true)
  int id = 0;
  bool isActive;
  @Unique()
  int time;

  AlarmModel(this.isActive, this.time);
  AlarmModel.withId(this.id, this.isActive, this.time);

  @override
  int compareTo(AlarmModel other) {
    return time - other.time;
  }
}