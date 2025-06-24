import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/design/app_image.dart';
import '../../features/weather/bloc.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}


class _WeatherViewState extends State<WeatherView> {
   final bloc = KiwiContainer().resolve<WeatherBloc>();
  Future<Position> getPermissionCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    return position;
  }
Future<Position> permission()async{
  final   location = await getPermissionCity();
  return location;
}
  Future<void> fetchPermissionAndLoadWeather() async {
    final getPermission = await permission();
    bloc.add(
      GetWeatherEvent(
        lat: getPermission.latitude.toString(),
        lon: getPermission.longitude.toString(),
      ),
    );
  }
   String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null) {
      return'assets/lotties/sunny.json';
    }
    switch(mainCondition.toLowerCase()){
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
    fetchPermissionAndLoadWeather();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is WeatherFailedState) {
              return const AppImage('weather_not_found.jpg');
            } else if (state is WeatherSuccessState) {
              final animationPath = getWeatherAnimation(state.model!.mainCondition);
              print(animationPath);
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    Text(
                      state.model!.cityName,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Spacer(),
                    Lottie.asset(animationPath,height: 200.h,width: 200.w),
                    Spacer(),
                    Text(
                      "${(state.model!.temperature - 273.15).round()}°C",
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
              return Center(child: CircularProgressIndicator(color: Colors.black),);
            }
          }),
    );
  }
}
