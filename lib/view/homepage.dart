import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final textController = TextEditingController();
  WeatherModel? response;
  bool isLoading = false;
  String message = 'Fetching weather data...';

  @override
  void initState() {
    super.initState();
    fetchWeatherByDeviceLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildSearch(),
              const SizedBox(height: 15),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Expanded(child: SingleChildScrollView(child: buildWeather())),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchWeatherByDeviceLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Future<void> fetchWeatherByDeviceLocation() async {
    setState(() {
      isLoading = true;
      message = 'Fetching location...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Get.defaultDialog(
          barrierDismissible: false,
          title: 'Location Services Disabled',
          content: const Text(
            'Please enable location services to get weather for your current location.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back();
                await Geolocator.openLocationSettings();

                bool enabled = await Geolocator.isLocationServiceEnabled();
                if (enabled) {
                  fetchWeatherByDeviceLocation();
                }
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                setState(() {
                  isLoading = false;
                  message = 'Search for a location';
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Get.defaultDialog(
          barrierDismissible: false,
          title: 'Location Permission Required',
          content: const Text(
            'Location permission is permanently denied. Please enable it in your device settings.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back();
                await Geolocator.openAppSettings();

                LocationPermission newPermission =
                    await Geolocator.checkPermission();
                if (newPermission != LocationPermission.denied &&
                    newPermission != LocationPermission.deniedForever) {
                  fetchWeatherByDeviceLocation();
                }
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                setState(() {
                  isLoading = false;
                  message = 'Search for a location';
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      }

      final position = await Geolocator.getCurrentPosition();

      response = await WeatherApi()
          .getCurrentWeather('${position.latitude},${position.longitude}');
    } catch (e) {
      setState(() {
        message = 'Please search for a location';
        response = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }
  }

  Widget buildSearch() {
    return SearchBar(
      controller: textController,
      hintText: "Search City",
      leading: const Icon(Icons.search),
      onSubmitted: (value) {
        if (value.isEmpty) {
          Get.defaultDialog(
            backgroundColor: const Color.fromRGBO(240, 240, 217, 0.984),
            title: "Required",
            content: const Text("Please enter a location to search"),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          );
        } else {
          getWeatherData(value);
          textController.clear();
        }
      },
    );
  }

  Widget buildWeather() {
    if (response == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, size: 70),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    response?.location?.name ?? "",
                    style: const TextStyle(fontSize: 40),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    response?.location?.country ?? "",
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "${response?.current?.tempC?.toStringAsFixed(1) ?? ""} °C",
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: Text(
                response?.current?.condition?.text ?? "",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Image.network(
                  "https:${response?.current?.condition?.icon}",
                  scale: 0.2,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadowColor: Colors.amber,
              elevation: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      humidityAndWind("Humidity:",
                          "${response?.current?.humidity?.toString() ?? ""}%"),
                      humidityAndWind("Wind Speed:",
                          "${response?.current?.windKph?.toString() ?? ""} km/h"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      humidityAndWind(
                          "UV:", response?.current?.uv?.toString() ?? ""),
                      humidityAndWind("Precipitation:",
                          "${response?.current?.precipMm?.toString() ?? ""} mm"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      humidityAndWind("Local Time:",
                          response?.location?.localtime?.split(" ").last ?? ""),
                      humidityAndWind(
                          "Local Date:",
                          response?.location?.localtime?.split(" ").first ??
                              ""),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget humidityAndWind(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> getWeatherData(String location) async {
    setState(() {
      isLoading = true;
    });
    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      setState(() {
        message =
            'Location not found. Please check the spelling and try again.';
        response = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
