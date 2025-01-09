import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/view/homepage.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actualHeight = MediaQuery.of(context).size.height;
    Future.delayed(Duration(seconds: 5), () {
      Get.to(() => Homepage());
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/moru_background.png', fit: BoxFit.fill),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We show weather for you',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Homepage());
                },
                child: Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
