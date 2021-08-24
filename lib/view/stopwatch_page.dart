import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:flutter_to_do_clock/widgets/stopwatch/button_widget.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  final _scrollController = ScrollController();

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
            AppLocalizations.of(context)!.stopwatch,
            style: Theme.of(context).textTheme.headline4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime = StopWatchTimer.getDisplayTime(value,
                      hours: _isHours, milliSecond: false);
                  return Text(displayTime,
                      style: Theme.of(context).textTheme.subtitle1);
                },
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
              Container(
                height: MediaQuery.of(context).size.height / 4,
                margin: const EdgeInsets.all(8),
                child: StreamBuilder<List<StopWatchRecord>>(
                  stream: _stopWatchTimer.records,
                  initialData: _stopWatchTimer.records.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    if (value.isEmpty) {
                      return Container();
                    }
                    Future.delayed(const Duration(milliseconds: 100), () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut);
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final data = value[index];
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${index + 1} ${data.displayTime}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: value.length,
                    );
                  },
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomButton(
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          label: AppLocalizations.of(context)!.start),
                      CustomButton(
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },
                          label: AppLocalizations.of(context)!.stop),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CustomButton(
                          onPress: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          label: AppLocalizations.of(context)!.lap),
                      CustomButton(
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          label: AppLocalizations.of(context)!.reset),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}