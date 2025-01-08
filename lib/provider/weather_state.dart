// import 'package:weather_app/model/weather_model.dart';

// class WeatherState {
//   final bool isLoading;
//   final List<WeatherModel> weatherModel;
//   final String error;
//   final String apiPath;
//   final String q;
//   final bool loadMore;
//   final int day;
//   WeatherState({
//     required this.isLoading,
//     required this.weatherModel,
//     required this.error,
//     required this.apiPath,
//     required this.q,
//     required this.loadMore,
//     required this.day,
//   });

//   get state => null;
//   WeatherState copyWith({
//     required WeatherState weatherState,
//     bool? isLoading,
//     List<WeatherModel>? weatherModel,
//     String? error,
//     String? apiPath,
//     String? q,
//     bool? loadMore,
//     int? day,
//   }) {
//     return WeatherState(
//       isLoading: isLoading ?? weatherState.isLoading,
//       weatherModel: weatherModel ?? weatherState.weatherModel,
//       error: error ?? weatherState.error,
//       apiPath: apiPath ?? weatherState.apiPath,
//       q: q ?? weatherState.q,
//       loadMore: loadMore ?? weatherState.loadMore,
//       day: day ?? weatherState.day,
//     );
//   }

//   String when(
//       {required Function(dynamic data) data,
//       required String Function() loading,
//       required String Function(dynamic error, dynamic _) error}) {
//     // Add your logic here
//     return '';
//   }

//   void getData({required String searchText}) {}
// }
