import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:weather_app/features/kiwi.dart';
import 'package:weather_app/features/weather/bloc.dart';
import 'package:weather_app/view/weather/view.dart';

void main() {
  runApp(const MyApp());
  initKiwi();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
      return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather_app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: child
        );
      },
      child: WeatherView()
    );
  }
}

