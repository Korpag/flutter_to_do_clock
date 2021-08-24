import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_to_do_clock/models/tasks_add_info.dart';
import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:flutter_to_do_clock/utils/images/images.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _model = AddTaskWidgetModel();

  @override
  Widget build(BuildContext context) {
    return AddTaskWidgetModelProvider(
        model: _model, child: const _AddTaskWidgetBody());
  }
}

class _AddTaskWidgetBody extends StatelessWidget {
  const _AddTaskWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AddTaskWidgetModelProvider.read(context)?.model;
    return Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
              barrierColor: appPrimaryColor.withOpacity(0.9),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                              cursorColor: appSecondaryColor,
                              style: Theme.of(context).textTheme.headline2,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.description,
                                  labelStyle:
                                      Theme.of(context).textTheme.headline6),
                              onChanged: (value) => model?.taskTitle = value),
                        ),
                        TextButton(
                            onPressed: () => model?.saveTask(context),
                            child: Text(
                              AppLocalizations.of(context)!.addTask,
                              style: Theme.of(context).textTheme.headline1,
                            ))
                      ],
                    ));
              });
        },
        child: Image.asset(
          add,
          color: appSecondaryColor,
          scale: 1.75,
        ),
      ),
    );
  }
}
