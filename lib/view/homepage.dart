import 'package:flutter/material.dart';
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
  String message = 'Search the Location';

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
              CircularProgressIndicator()
            else
              Expanded(child: SingleChildScrollView(child: buildWeather())),
          ],
        ),
      ),
    ));
  }

  Widget buildSearch() {
    return SearchBar(
      controller: textController,
      hintText: "Search City ",
      onSubmitted: (value) {
        getWeatherData(value);
        if (value.isEmpty) {
          Get.defaultDialog(
            backgroundColor: Color.fromRGBO(240, 240, 217, 0.984),
            title: "Required",
            content: Text("Add Location to search"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Confirm"),
              ),
            ],
          );
        } else {
          final newWeather = textController.clear();
        }
      },
    );
  }

  Widget buildWeather() {
    if (response == null) {
      return Text(message);
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                size: 70,
              ),
              Column(
                children: [
                  Text(
                    response?.location?.name ?? "",
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    response?.location?.country ?? "",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  (response?.current?.tempC.toString() ?? "") + " °C",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Text(
                  response?.current?.condition?.text.toString() ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Image.network(
                    "https:${response?.current?.condition?.icon}",
                    scale: .2,
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
                            response?.current?.humidity?.toString() ?? ""),
                        humidityAndWind(
                            "Wind Speed:",
                            (response?.current?.humidity?.toString() ?? "") +
                                " km/h"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        humidityAndWind(
                            "UV:", response?.current?.uv?.toString() ?? ""),
                        humidityAndWind("Percipitation:",
                            response?.current?.precipMm?.toString() ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        humidityAndWind(
                            "Local Time:",
                            response?.location?.localtime?.split(" ").last ??
                                ""),
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
  }

  Widget humidityAndWind(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  getWeatherData(String location) async {
    setState(() {
      isLoading = true;
    });
    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      setState(() {
        message = 'Input the correct location';
        response = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
