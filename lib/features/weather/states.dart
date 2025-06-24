part of 'bloc.dart';
class WeatherStates{}
class WeatherLoadingState extends WeatherStates{}
class WeatherSuccessState extends WeatherStates{
 final Weather? model;
  WeatherSuccessState({required this.model});
}
class WeatherFailedState extends WeatherStates{}