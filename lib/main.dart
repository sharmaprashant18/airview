import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_app/view/animated_splash.dart';

void main() async {
  runApp(ProviderScope(child: Home()));
  await Future.delayed(Duration(milliseconds: 100));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
