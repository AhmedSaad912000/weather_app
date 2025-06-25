part of 'bloc.dart';
class WeatherEvents{}
class GetWeatherEvent extends WeatherEvents{
  final String countryName;

  GetWeatherEvent({required this.countryName});
}


