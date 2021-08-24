import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_to_do_clock/domain/entity/tasks.dart';

//creating a class for adding a task
class AddTaskWidgetModel extends ChangeNotifier {
  var taskTitle = '';

  void saveTask(BuildContext context) async {
    if (taskTitle.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TasksAdapter());
    }
    final box = await Hive.openBox<Tasks>('tasks_box');
    final task = Tasks(name: taskTitle);
    await box.add(task);
    Navigator.of(context).pop();
  }
}

//creating an Inherited
class AddTaskWidgetModelProvider extends InheritedWidget {
  final AddTaskWidgetModel model;

  const AddTaskWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static AddTaskWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AddTaskWidgetModelProvider>()
        ?.widget;
    return widget is AddTaskWidgetModelProvider ? widget : null;
  }

  static AddTaskWidgetModelProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<AddTaskWidgetModelProvider>();
    assert(result != null, 'No TasksInfoAddProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AddTaskWidgetModelProvider old) {
    return true;
  }
}
