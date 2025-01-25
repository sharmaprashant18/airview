import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherApi {
  final String currentWeather = "http://api.weatherapi.com/v1/current.json";

  Future<WeatherModel> getCurrentWeather(String location) async {
    String apiUrl = "$currentWeather?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather");
    }
  }
}
// http://api.weatherapi.com/v1/current.json
// String apiUrl = "$currentWeather?key=$apiKey&q=$location";
