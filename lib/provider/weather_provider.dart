import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/provider/weather_state.dart';
import 'package:weather_app/services/dio.dart';

final currentWeatherProvider =
    StateNotifierProvider<CurrentWeatherProvider, WeatherState>(
        (ref) => CurrentWeatherProvider(WeatherState(
              isLoading: false,
              weatherModel: [],
              error: '',
              apiPath: Api.currentWeather,
              q: 'London',
              loadMore: false,
              day: 1,
            )));

class CurrentWeatherProvider extends StateNotifier<WeatherState> {
  var weatherModel;

  CurrentWeatherProvider(super.state) {
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

  void loadMore() {
    state = state.copyWith(weatherState: state, loadMore: true);
    getData();
  }

  void updateWeather(String value) {}

  void getCurrentWeather(String value) {}
}

final weatherForeCastProvider =
    StateNotifierProvider<WeatherForeCastProvider, WeatherState>(
        (ref) => WeatherForeCastProvider(WeatherState(
              isLoading: false,
              weatherModel: [],
              error: '',
              apiPath: Api.weatherForecast,
              q: 'London',
              loadMore: false,
              day: 1,
            )));

class WeatherForeCastProvider extends StateNotifier<WeatherState> {
  WeatherForeCastProvider(super.state) {
    getData();
  }
  Future<void> getData() async {
    state = state.copyWith(
        weatherState: state, isLoading: state.loadMore ? false : true);
    final response = await WeatherService.getWeatherForecast(
      apiPath: state.apiPath,
      q: state.q,
      day: state.day,
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

  void loadMore() {
    state = state.copyWith(weatherState: state, loadMore: true);
    getData();
  }
}
