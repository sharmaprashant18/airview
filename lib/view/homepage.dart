import 'package:flutter/material.dart';
import 'package:weather_app/services/geolocator.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        // margin: const EdgeInsets.only(top: 00, left: 300),
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final location = await getLocation();
            },
            child: const Text('Get Location'),
          ),
        ),
      ),
    );
  }
}
