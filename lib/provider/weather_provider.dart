import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/provider/weather_state.dart';
import 'package:weather_app/services/dio.dart';

final weatherProvider = StateNotifierProvider<WeatherProvider, WeatherState>(
    (ref) => WeatherProvider(WeatherState(
          isLoading: false,
          weatherModel: [],
          error: '',
          apiPath: Api.currentWeather,
          q: '',
          loadMore: false,
          day: 1,
        )));

class WeatherProvider extends StateNotifier<WeatherState> {
  WeatherProvider(super.state) {
    getData();
  }
  Future<void> getData() async {
    state = state.copyWith(
        weatherState: state, isLoading: state.loadMore ? false : true);
    final response = await WeatherService.getCurrentWeather(
      apiPath: state.apiPath,
      q: state.q,
    );
    response.fold(
      (l) => state = state.copyWith(
        weatherState: state,
        isLoading: false,
        error: l,
      ),
      (r) => state = state.copyWith(
        weatherState: state,
        isLoading: false,
        weatherModel: [...state.weatherModel, ...r],
      ),
    );
  }
}
