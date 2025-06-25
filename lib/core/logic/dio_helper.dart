import 'package:dio/dio.dart';
class WeatherServices {
  static final _dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.openweathermap.org/data/2.5',
        receiveDataWhenStatusError: true,

      )
  );
static  Future<CustomResponse> get({Map<String, dynamic>?data}) async {
    try {
      data?.addAll({
        'appid': '751993d9edbc3d8e991a86cca1bf3b57',
        'units': 'metric',



      });
      final response = await _dio.get('/weather', queryParameters: data);
      return CustomResponse(
        isSuccess: true, data: response.data, statusCode: response.statusCode,);
    }on DioException catch(ex){
      return CustomResponse(
      isSuccess: false,
    data: ex.response?.data,
    statusCode: ex.response?.statusCode,
    msg: ex.error.toString());
    }
  }
 static Future<CustomResponse> send(String path,{Map<String,dynamic>? data})async{
    try {
      final response = await _dio.get(path, data: data);
      return CustomResponse(
        isSuccess: true, data: response.data, statusCode: response.statusCode,);
    }on DioException catch(ex){
      return CustomResponse(
          isSuccess: false,
          data: ex.response?.data,
          statusCode: ex.response?.statusCode,
          msg: ex.error.toString());
    }
  }
}

class CustomResponse {
  final String msg;
  final bool isSuccess;
  final data;
  final int? statusCode;

  CustomResponse({
    this.statusCode,
    required this.isSuccess,
    this.data,
    this.msg = '',
  });
}