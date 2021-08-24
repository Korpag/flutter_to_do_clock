import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_to_do_clock/models/menu_info.dart';
import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:flutter_to_do_clock/utils/images/images.dart';
import 'package:flutter_to_do_clock/view/calculator_page.dart';
import 'package:flutter_to_do_clock/view/clock_page.dart';
import 'package:flutter_to_do_clock/view/stopwatch_page.dart';
import 'package:flutter_to_do_clock/view/tasks_page.dart';
import 'package:flutter_to_do_clock/view/timer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuItems = <MenuInfo>[
      MenuInfo(MenuType.tasks,
          title: AppLocalizations.of(context)!.tasks, imageSource: tasks),
      MenuInfo(MenuType.calculator,
          title: AppLocalizations.of(context)!.calculator,
          imageSource: calculator),
      MenuInfo(MenuType.clock,
          title: AppLocalizations.of(context)!.clock, imageSource: clock),
      MenuInfo(MenuType.stopwatch,
          title: AppLocalizations.of(context)!.stopwatch,
          imageSource: stopwatch),
      MenuInfo(MenuType.timer,
          title: AppLocalizations.of(context)!.timer, imageSource: timer),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems
                  .map((currentMenuInfo) =>
                      buildTextButton(context, currentMenuInfo))
                  .toList()),
          VerticalDivider(
            color: appTertiaryColor.withOpacity(0.7),
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType == MenuType.clock) {
                  return const ClockPage();
                } else if (value.menuType == MenuType.tasks) {
                  return const TasksPage();
                } else if (value.menuType == MenuType.calculator) {
                  return CalculatorPage();
                } else if (value.menuType == MenuType.stopwatch) {
                  return const StopwatchPage();
                } else if (value.menuType == MenuType.timer) {
                  return const TimerPage();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextButton(BuildContext context, MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return TextButton(
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  currentMenuInfo.imageSource ?? '',
                  scale: currentMenuInfo.menuType == value.menuType ? 1.3 : 1.5,
                  color: currentMenuInfo.menuType == value.menuType
                      ? appTertiaryColorWithOp
                      : appSecondaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  currentMenuInfo.title ?? '',
                  style: currentMenuInfo.menuType == value.menuType
                      ? Theme.of(context).textTheme.headline6
                      : Theme.of(context).textTheme.headline2,
                )
              ],
            ));
      },
    );
  }
}
