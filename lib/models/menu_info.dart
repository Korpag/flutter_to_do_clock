import 'package:flutter/material.dart';

//fixed set of constant values for menu types
enum MenuType { tasks, clock, calculator, stopwatch, timer }

//creating a menu class
class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String? title;
  String? imageSource;

  MenuInfo(this.menuType, {this.title, this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
