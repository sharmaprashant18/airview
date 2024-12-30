import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/provider/weather_state.dart';
import 'package:weather_app/services/dio.dart';

final weatherSearchProvider =
    StateNotifierProvider.autoDispose<WeatherSearchProvider, WeatherState>(
        (ref) => WeatherSearchProvider(WeatherState(
              isLoading: false,
              weatherModel: [],
              error: '',
              apiPath: Api.searchWeather,
              q: '',
              loadMore: false,
              day: 1,
            )));

class WeatherSearchProvider extends StateNotifier<WeatherState> {
  WeatherSearchProvider(super.state) {}
  Future<void> getData({required searchText}) async {
    state = state.copyWith(
        weatherState: state, isLoading: state.loadMore ? false : true);
    final response = await WeatherService.searchWeather(
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
    (r) {
      if (r.isEmpty) {
        state = state.copyWith(
          weatherState: state,
          isLoading: false,
          error: 'No data found',
        );
      } else {
        state = state.copyWith(
          weatherState: state,
          isLoading: false,
          weatherModel: [...state.weatherModel, ...r],
        );
      }
    };
  }

  void loadMore() {
    state = state.copyWith(weatherState: state, loadMore: true);
    getData(searchText: null);
  }
}
