class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;
  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        location: Location.fromJson(json['location']),
        current: Current.fromJson(json['current']),
        forecast: Forecast.fromJson(json['forecast']));
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
  final DateTime localtime;
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
        name: json['name'],
        region: json['region'],
        country: json['country'],
        lat: json['lat'],
        lon: json['lon'],
        tz_id: json['tz_id'],
        localtimeEpoch: json['localtime_epoch'],
        localtime: DateTime.parse(json['localtime']));
  }
}

class Current {
  final int last_Updated_epoch;
  final DateTime last_updated;
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
        last_Updated_epoch: json['last_updated_epoch'],
        last_updated: DateTime.parse(json['last_updated']),
        temp_c: json['temp_c'],
        temp_f: json['temp_f']);
  }
}

class Forecast {
  final List<Forecastday> forecastday;
  Forecast({required this.forecastday});
  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<Forecastday> forecastday = [];
    for (var item in json['forecastday']) {
      forecastday.add(Forecastday.fromJson(item));
    }
    return Forecast(forecastday: forecastday);
  }
}

class Forecastday {
  final DateTime date;
  Day day;
  Forecastday({required this.date, required this.day});
  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
        date: DateTime.parse(json['date']), day: Day.fromJson(json['day']));
  }
}

class Day {
  Day() {}

  Day.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
