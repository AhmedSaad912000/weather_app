import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();


void navigateTo(Widget page, {withHistory = true}) {
  Navigator.pushAndRemoveUntil(
   navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => withHistory,
  );
}
