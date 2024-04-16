
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BatState {
  Full,
  Half_Full75,
  Half_Full50,
  Half_Full25,
  Low,
}



class BatUtils {
  static Widget? getBatIcon(BatState? batState) {
    String img = "";
    Icon? icon;
    switch (batState) {
      case BatState.Full:
        img = 'battery100.svg';
        break;
      case BatState.Half_Full75:
        img = 'battery75.svg';
        break;
      case BatState.Half_Full50:
        img = 'battery50.svg';
        break;
      case BatState.Half_Full25:
        img = 'battery25.svg';
        break;
      case BatState.Low:
        img = 'batterylow.svg';
        break;
      default:
        icon = const Icon(
          Icons.warning,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = SvgPicture.asset(
        'assets/bat/$img',
        height: 15.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

}

