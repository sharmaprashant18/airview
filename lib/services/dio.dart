// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/model/weather_model.dart';

// class WeatherService {
//   static Dio dio = Dio();
//   static Future<Either<String, List<WeatherModel>>> getCurrentWeather(
//       {required String apiPath, required String q}) async {
//     try {
//       final response = await dio.get(apiPath,
//           queryParameters: {'key': 'ffa8bc7cc16b486d85f103719242912', 'q': q});
//       final newData = (response.data['location'] as List)
//           .map((e) => WeatherModel.fromJson(e))
//           .toList();

//       return Right(newData);
//     } on DioException catch (e) {
//       return Left(e.message as String);
//     }
//   }

//   static Future<Either<String, List<WeatherModel>>> getWeatherForecast(
//       {required String apiPath, required String q, required int day}) async {
//     try {
//       final response = await dio.get(apiPath, queryParameters: {
//         'key': 'ffa8bc7cc16b486d85f103719242912',
//         'q': q,
//         'days': day
//       });
//       final newData = (response.data['data'] as List)
//           .map((e) => WeatherModel.fromJson(e))
//           .toList();
//       return Right(newData);
//     } on DioException catch (e) {
//       return Left(e.message as String);
//     }
//   }

//   static Future<Either<String, List<WeatherModel>>> searchWeather(
//       {required String apiPath, required String q}) async {
//     try {
//       final response = await dio.get(apiPath,
//           queryParameters: {'key': 'ffa8bc7cc16b486d85f103719242912', 'q': q});
//       final newData = (response.data['data'] as List)
//           .map((e) => WeatherModel.fromJson(e))
//           .toList();
//       return Right(newData);
//     } on DioException catch (e) {
//       return Left(e.message as String);
//     }
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
