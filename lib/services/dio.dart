import 'package:dio/dio.dart';

class WeatherService {
  static Dio dio = Dio();
  static Future getWeather() async {
    try {
      final response = await dio
          .get('https://api.weatherapi.com/v1/current.json', queryParameters: {
        'api_key': 'ffa8bc7cc16b486d85f103719242912',
      });
    } catch (e) {
      print(e);
    }
  }
}
