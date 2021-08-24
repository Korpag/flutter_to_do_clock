import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_to_do_clock/utils/constants/constants.dart';

class ClockWidget extends StatefulWidget {
  final double size;

  const ClockWidget({Key? key, required this.size}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var circlePaint = Paint()
      ..color = appSecondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    canvas.drawCircle(center, radius * 0.75, circlePaint);

    var hourArrowPaint = Paint()
      ..color = appTertiaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;
    var hourArrowX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourArrowY = centerY +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourArrowX, hourArrowY), hourArrowPaint);

    var minArrowPaint = Paint()
      ..color = appTertiaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;
    var minArrowX =
        centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minArrowY =
        centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minArrowX, minArrowY), minArrowPaint);

    var secArrowPaint = Paint()
      ..color = appTertiaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;
    var secArrowX =
        centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secArrowY =
        centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secArrowX, secArrowY), secArrowPaint);

    var centerCirclePaint = Paint()..color = appSecondaryColor;
    canvas.drawCircle(center, radius * 0.12, centerCirclePaint);

    var dialPaint = Paint()
      ..color = appTertiaryColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dialPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
