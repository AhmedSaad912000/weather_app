import 'package:kiwi/kiwi.dart';
import 'package:weather_app/features/weather/bloc.dart';

void initKiwi(){
  final container=KiwiContainer();
  container.registerFactory((container) => WeatherBloc());

}