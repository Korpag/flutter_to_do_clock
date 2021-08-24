import 'package:hive/hive.dart';

part 'tasks.g.dart';

//creating an entity for Hive

@HiveType(typeId: 1)
class Tasks {
  @HiveField(0)
  String name;

  Tasks({required this.name});
}
