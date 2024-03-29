import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
