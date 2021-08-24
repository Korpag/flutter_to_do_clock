import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:flutter_to_do_clock/utils/icons/icons.dart';
import 'package:flutter_to_do_clock/widgets/clock/clock_widget.dart';
import 'package:flutter_to_do_clock/widgets/clock/digital_clock_widget.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE, d MMM', languageCode).format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              AppLocalizations.of(context)!.clock,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const DigitalClockWidget(),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              )),
          Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Align(
                  alignment: Alignment.center,
                  child: ClockWidget(
                      size: MediaQuery.of(context).size.height / 4))),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.timeZone,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      timeZone,
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!.utc +
                            offsetSign +
                            timezoneString,
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
