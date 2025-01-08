import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class Api {
  final String baseUrl = 'https://api.weatherapi.com/v1/current.json';
  final String weatherForecast = 'https://api.weatherapi.com/v1/forecast.json';
  final String searchWeather = 'https://api.weatherapi.com/v1/search.json';
  Future getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apikey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
