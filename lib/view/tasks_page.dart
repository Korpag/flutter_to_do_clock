import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_to_do_clock/models/tasks_info.dart';
import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:flutter_to_do_clock/widgets/tasks/add_task_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _model = TasksPageInfoModel();

  @override
  Widget build(BuildContext context) {
    return TasksPageInfoModelProvider(
      model: _model,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.tasks,
              style: Theme.of(context).textTheme.headline4,
            ),
            const Expanded(child: _TasksWidgetBuilder()),
            const AddTaskWidget()
          ],
        ),
      ),
    );
  }
}

class _TasksWidgetBuilder extends StatelessWidget {
  const _TasksWidgetBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksCount =
        TasksPageInfoModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.builder(
        itemCount: tasksCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: appSecondaryColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: _TasksWidget(
                indexInList: index,
              ));
        });
  }
}

class _TasksWidget extends StatelessWidget {
  final int indexInList;

  const _TasksWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksPageInfoModelProvider.read(context)!.model;
    final task =
        TasksPageInfoModelProvider.read(context)!.model.tasks[indexInList];
    return ListTile(
        title: Text(task.name,
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.justify),
        onTap: () {
          showModalBottomSheet(
              barrierColor: appPrimaryColor.withOpacity(0.9),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(AppLocalizations.of(context)!.deleteTask,
                            style: Theme.of(context).textTheme.headline4),
                        // SizedBox(height: MediaQuery.of(context).size.height / 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(AppLocalizations.of(context)!.no,
                                    style:
                                        Theme.of(context).textTheme.headline1)),
                            TextButton(
                                onPressed: () => {
                                      model.deleteTask(indexInList),
                                      Navigator.pop(context)
                                    },
                                child: Text(AppLocalizations.of(context)!.yes,
                                    style:
                                        Theme.of(context).textTheme.headline1)),
                          ],
                        )
                      ],
                    ));
              });
        });
  }
}
