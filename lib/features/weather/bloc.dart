import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/logic/dio_helper.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';
class WeatherBloc extends Bloc<WeatherEvents,WeatherStates>{
  WeatherBloc():super(WeatherStates()){
    on<GetWeatherEvent>(getWeather);
  }
  Future<void> getWeather(GetWeatherEvent event, Emitter<WeatherStates> emit) async {
    emit(WeatherLoadingState());

    print(" جاري جلب بيانات الطقس للمدينة: ${event.countryName}");

    final responseWeather = await WeatherServices.get(data: {
      "q": event.countryName,
    });

    if (responseWeather.isSuccess) {
      print(" ${responseWeather.data}البيانات المستلمة:");
      final model = Weather.fromJson(responseWeather.data);
      emit(WeatherSuccessState(model: model));
    } else {
      emit(WeatherFailedState());
    }
  }



}

