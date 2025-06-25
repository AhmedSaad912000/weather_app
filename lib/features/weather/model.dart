part of 'bloc.dart';
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String countryCode;

  Weather({
    required this.cityName,
    required this.countryCode,
    required this.temperature,
    required this.mainCondition,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"]??'غير معرف',
      countryCode: json['sys'] != null && json['sys']['country'] != null
          ? json['sys']['country'] as String
          : 'N/A',      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'] ?? 'Clear',
    );
  }
}
