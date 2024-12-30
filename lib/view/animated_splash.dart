import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/view/homepage.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final actualHeight = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: LottieBuilder.asset('assets/weather_animated.json'),
            ),
          )
        ],
      ),
      nextScreen: Homepage(),
      splashIconSize: actualHeight * 0.7,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: Duration(milliseconds: 200),
      backgroundColor: Colors.grey,
    );
  }
}
