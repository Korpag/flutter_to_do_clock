import 'package:flutter_to_do_clock/models/calculator_info.dart';
import 'package:flutter_to_do_clock/utils/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isColored, isEqualSign, canBeFirst;
  const CalculatorButton(
      this.label, {
        this.isColored = false,
        this.isEqualSign = false,
        this.canBeFirst = true,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider =
    Provider.of<CalculatorProvider>(context, listen: false);
    final textStyle = Theme.of(context).textTheme.headline1;
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          calculatorProvider.addToEquation(
            label,
            canBeFirst,
            context,
          );
        },
        child: Center(
          child: isEqualSign
              ? Container(
            height: mediaQuery.width * 0.1,
            width: mediaQuery.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: appSecondaryColor,
            ),
            child: Center(
              child: Text(
                label,
                style: textStyle?.copyWith(color: appPrimaryColor),
              ),
            ),
          )
              : Text(
            label,
            style: textStyle?.copyWith(
                color: isColored ? appSecondaryColor : appTertiaryColor),
          ),
        ),
      ),
    );
  }
}

List<CalculatorButton> buttons = <CalculatorButton>[
  const CalculatorButton('AC', isColored: true, canBeFirst: false),
  const CalculatorButton('⌫', isColored: true, canBeFirst: false),
  const CalculatorButton('.', isColored: true, canBeFirst: false),
  const CalculatorButton(' ÷ ', isColored: true, canBeFirst: false),
  const CalculatorButton('7'),
  const CalculatorButton('8'),
  const CalculatorButton('9'),
  const CalculatorButton(' × ', isColored: true, canBeFirst: false),
  const CalculatorButton('4'),
  const CalculatorButton('5'),
  const CalculatorButton('6'),
  const CalculatorButton(' - ', isColored: true, canBeFirst: false),
  const CalculatorButton('1'),
  const CalculatorButton('2'),
  const CalculatorButton('3'),
  const CalculatorButton(' + ', isColored: true, canBeFirst: false),
  const CalculatorButton('00'),
  const CalculatorButton('0'),
  const CalculatorButton('000'),
  const CalculatorButton('=', isEqualSign: true, canBeFirst: false),
];