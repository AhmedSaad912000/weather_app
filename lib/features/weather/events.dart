part of 'bloc.dart';
class WeatherEvents{}
class GetWeatherEvent extends WeatherEvents{
  final String lat,lon;

  GetWeatherEvent({ required this.lat,required this.lon});
}


