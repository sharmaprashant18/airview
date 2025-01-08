class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;
  final List<SearchWeather> searchWeather;
  WeatherModel(
      {required this.location,
      required this.current,
      required this.forecast,
      required this.searchWeather});
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
      searchWeather: (json['weather'] as List<dynamic>)
          .map((e) => SearchWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tz_id;
  final int localtimeEpoch;
  final String localtime;
  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz_id,
    required this.localtimeEpoch,
    required this.localtime,
  });
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json['name'] as String,
        region: json['region'] as String,
        country: json['country'] as String,
        lat: json['lat'] as double,
        lon: json['lon'] as double,
        tz_id: json['tz_id'],
        localtimeEpoch: json['localtime_epoch'] as int,
        localtime: json['localtime'] as String);
  }
}

class Current {
  final int last_Updated_epoch;
  final String last_updated;
  final double temp_c;
  final double temp_f;
  Current({
    required this.last_Updated_epoch,
    required this.last_updated,
    required this.temp_c,
    required this.temp_f,
  });
  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
        last_Updated_epoch: json['last_updated_epoch'] as int,
        last_updated: json['last_updated'] as String,
        temp_c: json['temp_c'] as double,
        temp_f: json['temp_f'] as double);
  }
}

class Forecast {
  final List<Forecastday> forecastday;
  Forecast({required this.forecastday});
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(forecastday: json['forecastday']);
  }
}

class Forecastday {
  final String date;
  final String day;
  Forecastday({required this.date, required this.day});
  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(date: json['date'], day: json['day']);
  }
}

class SearchWeather {
  final int id;
  final String name;
  final String region;
  final double lat;
  final double lon;
  final String url;
  SearchWeather(
      {required this.id,
      required this.name,
      required this.region,
      required this.lat,
      required this.lon,
      required this.url});
  factory SearchWeather.fromJson(Map<String, dynamic> json) {
    return SearchWeather(
        id: json['id'] as int,
        name: json['name'] as String,
        region: json['region'] as String,
        lat: json['lat'] as double,
        lon: json['lon'] as double,
        url: json['url'] as String);
  }
}
