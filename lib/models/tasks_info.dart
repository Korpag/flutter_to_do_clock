import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_to_do_clock/domain/entity/tasks.dart';

//creating a class for tasks
class TasksPageInfoModel extends ChangeNotifier {
  var _tasks = <Tasks>[];

  List<Tasks> get tasks => _tasks.toList();

  TasksPageInfoModel() {
    _setup();
  }

  void deleteTask(int taskIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TasksAdapter());
    }
    final box = await Hive.openBox<Tasks>('tasks_box');
    await box.deleteAt(taskIndex);
  }

  void _readTasksHive(Box<Tasks> box) {
    _tasks = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TasksAdapter());
    }
    final box = await Hive.openBox<Tasks>('tasks_box');
    _readTasksHive(box);
    box.listenable().addListener(() {
      _readTasksHive(box);
    });
  }
}

//creating an Inherited
class TasksPageInfoModelProvider extends InheritedNotifier {
  final TasksPageInfoModel model;

  const TasksPageInfoModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TasksPageInfoModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksPageInfoModelProvider>();
  }

  static TasksPageInfoModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksPageInfoModelProvider>()
        ?.widget;
    return widget is TasksPageInfoModelProvider ? widget : null;
  }

  static TasksPageInfoModelProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<TasksPageInfoModelProvider>();
    assert(result != null, 'No TasksInfoAddProvider found in context');
    return result!;
  }
}
