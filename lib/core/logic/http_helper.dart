import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/weather/model.dart';
import 'package:http/http.dart ' as http;

class WeatherServices{
  static const   baseUrl='https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  WeatherServices(this.apiKey);
  Future<Weather> getWeather(String cityName)async{
    final response= await http.get(Uri.parse("$baseUrl?q=$cityName&appid=$apiKey&units=metric"));
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));

    }else{
      throw Exception("Failed to load data");
    }


  }
  Future<String> getCurrenCity()async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }

    final position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    List<Placemark>placemark=await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city=placemark[0].locality;
    return city??"";

  }

}