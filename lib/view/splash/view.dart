import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/core/design/app_image.dart';
import 'package:weather_app/core/logic/helper_methods.dart';
import 'package:weather_app/view/get_country/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      navigateTo(CountryPickerView(),withHistory: false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppImage(
        'city_weather.jpg',
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
