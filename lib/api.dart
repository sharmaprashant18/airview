import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/model/weather_model.dart';

class Api {
  static Dio dio = Dio();
  final String currentWeather = 'https://api.weatherapi.com/v1/current.json';
  final String weatherForecast = 'https://api.weatherapi.com/v1/forecast.json';
  final String searchWeather = 'https://api.weatherapi.com/v1/search.json';
  Future<WeatherModel> getCurrentWeather(String location) async {
    String apiUrl = '$currentWeather?key=$apikey&q=$location';
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.data));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
