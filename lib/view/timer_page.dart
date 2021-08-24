import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:flutter_to_do_clock/widgets/stopwatch/button_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countDown);

  final _isHours = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.timer,
            style: Theme.of(context).textTheme.headline4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data!;
                      final displayTime = StopWatchTimer.getDisplayTime(value,
                          hours: _isHours, milliSecond: false);
                      return Center(
                        child: Text(displayTime,
                            style: Theme.of(context).textTheme.subtitle1),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: () async {
                            _stopWatchTimer.setPresetHoursTime(1);
                          },
                          child: const SizedBox()),
                      TextButton(
                          onPressed: () async {
                            _stopWatchTimer.setPresetMinuteTime(1);
                          },
                          child: const SizedBox()),
                      TextButton(
                          onPressed: () async {
                            _stopWatchTimer.setPresetSecondTime(1);
                          },
                          child: const SizedBox()),
                    ],
                  )
                ],
              ),
              Divider(
                indent: MediaQuery.of(context).size.height / 15,
                endIndent: MediaQuery.of(context).size.height / 15,
                height: 1,
                color: appTertiaryColorWithOp,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton(
                      onPress: () async {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                      },
                      label: AppLocalizations.of(context)!.start),
                  CustomButton(
                      onPress: () async {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      },
                      label: AppLocalizations.of(context)!.stop),
                ],
              ),
              CustomButton(
                  onPress: () async {
                    _stopWatchTimer.clearPresetTime();
                  },
                  label: AppLocalizations.of(context)!.reset),
            ],
          ),
          // Row(children: <Widget>[
          //
          // ],)
        ],
      ),
    );
  }
}
