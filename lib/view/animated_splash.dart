// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get/get.dart';
// // import 'package:lottie/lottie.dart';
// import 'package:weather_app/view/homepage.dart';

// class Splashscreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     FlutterNativeSplash.remove();
//     // final actualHeight = MediaQuery.of(context).size.height;
//     return AnimatedSplashScreen(
//       duration: 3000,
//       splash: Stack(
//         children: [
//           Image.asset(
//             'assets/moru_background.png',
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('We Show Weather For You',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.to<dynamic>(() => Homepage());
//                 },
//                 child: Text('Skip'),
//               )
//             ],
//           ),
//         ],
//       ),
//       // splash: Column(
//       //   children: [
//       //     Srta// Center(
//       //     //   child: Padding(
//       //     //     padding: const EdgeInsets.only(top: 150),
//       //     //     child: LottieBuilder.asset('assets/weather_animated.json'),
//       //     //   ),
//       //     // )
//       //   ],
//       // ),
//       nextScreen: Homepage(),
//       // splashIconSize: actualHeight * 0.7,
//       splashTransition: SplashTransition.fadeTransition,
//       animationDuration: Duration(milliseconds: 500),
//       backgroundColor: Colors.grey,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/homepage.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actualHeight = MediaQuery.of(context).size.height;
    Future.delayed(Duration(seconds: 5), () {
      Get.to<dynamic>(() => HomePage());
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
                  Get.to(() => HomePage());
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
