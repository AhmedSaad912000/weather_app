part of 'bloc.dart';
class WeatherEvents{}
class GetWeatherEvent extends WeatherEvents{
  final String cityName;

  GetWeatherEvent({required this.cityName});
}


