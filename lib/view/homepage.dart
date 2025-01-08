import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/geolocator.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final weather = ref.read(currentWeatherProvider.notifier);

          return Container(
            child: Column(
              children: [
                Text('$weather'),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final location = await getLocation();
                    },
                    child: const Text('Get Location'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
