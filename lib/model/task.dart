import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime startDate;

  @HiveField(2)
  final String description;
  Task(
      {required this.description,
      required this.startDate,
      required this.title});
}
