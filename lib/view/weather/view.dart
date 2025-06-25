import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/design/app_image.dart';
import '../../features/weather/bloc.dart';

class WeatherView extends StatefulWidget {

  final String? countryName;
  final String? cityName;


  const WeatherView({super.key, required this.countryName, required this.cityName});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final bloc = KiwiContainer().resolve<WeatherBloc>();
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/lotties/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/lotties/snow.json';
      case 'shower rain':
        return 'assets/lotties/thuder.json';
      case 'rain':
        return 'assets/lotties/rain.json';
      default:
        return 'assets/lotties/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetWeatherEvent(countryName: widget.countryName!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is WeatherFailedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppImage('weather_not_found.jpg'),
                    const SizedBox(height: 16),
                    Text(
                      'تعذر جلب بيانات الطقس، يرجى المحاولة مرة أخرى',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );

            } else if (state is WeatherSuccessState) {
              final animationPath =
              getWeatherAnimation(state.model!.mainCondition);
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    Text(
                      state.model!.countryCode,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Spacer(),
                    Lottie.asset(animationPath, height: 200.h, width: 200.w),
                    Spacer(),
                    Text(
                      "${state.model!.temperature.toStringAsFixed(1)}°C",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
          }),
    );
  }
  }



