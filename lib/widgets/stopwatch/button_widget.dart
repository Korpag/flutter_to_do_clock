import 'package:flutter/material.dart';

import 'package:flutter_to_do_clock/utils/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final Function() onPress;
  final String label;

  const CustomButton({Key? key, required this.label, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        border: Border.all(color: appSecondaryColor, width: 2),
        borderRadius: BorderRadius.all(const Radius.circular(10)),
      ),
      child: TextButton(
          onPressed: onPress,
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline1,
          )),
    );
  }
}
