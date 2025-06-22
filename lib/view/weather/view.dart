import 'package:flutter/material.dart';

import '../../core/logic/http_helper.dart';
import '../../features/weather/model.dart';
class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}
class _WeatherViewState extends State<WeatherView> {
  final _weatherService=WeatherServices('751993d9edbc3d8e991a86cca1bf3b57');
  Weather?_weather;
  _fetchWeather()async{
    String name=await _weatherService.getCurrenCity();
    try{
      final weather=await _weatherService.getWeather(name);
      setState(() {
        _weather=weather;
      });
    }catch(ex){
      print(ex);
    }

  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_weather?.cityName??" Loading City......"),
            Text("${_weather?.temperature.round().toString()}  C"),
            Text(_weather?.mainCondition??""),
          ],
        ),
      ),
    );
  }
}