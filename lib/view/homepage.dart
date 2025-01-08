// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// class Homepage extends StatelessWidget {
//   final textController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer(
//         builder: (context, ref, child) {
//           return SafeArea(
//               child: Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: TextFormField(
//                     controller:
//                         textController, // textController given below the Stless is called in the controller
//                     decoration: InputDecoration(
//                         hintText: 'Search Weather',
//                         hintStyle: TextStyle(fontSize: 20)),
//                     onFieldSubmitted: (value) {
//                       if (value.isEmpty) {
//                         Get.defaultDialog(
//                             backgroundColor:
//                                 Color.fromRGBO(240, 240, 217, 0.984),
//                             title: 'Required',
//                             content: Text('Add LOCATION to search'),
//                             actions: [
//                               TextButton(
//                                   onPressed: () {
//                                     Get.back(); //Helps to go back after clicking the text button
//                                   },
//                                   child: Text('Confirm'))
//                             ]);
//                       } else {
//                         final newWeather = textController
//                             .clear(); //clear the text after clicking done from the search bar and it called from the TextFormfield
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/api.dart';
import 'package:weather_app/model/weather_model.dart';

class Homepage extends StatelessWidget {
  final textController = TextEditingController();
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchWidget(),
          ],
        ),
      ),
    ));
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: 'Search Location',
      controller: textController,
      onSubmitted: (value) {
        // _getWeatherData(value);
        if (value.isEmpty) {
          Get.defaultDialog(
              backgroundColor: Color.fromRGBO(240, 240, 217, 0.984),
              title: 'Required',
              content: Text('Add LOCATION to search'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back(); //Helps to go back after clicking the text button
                    },
                    child: Text('Confirm'))
              ]);
        } else {
          final newWeather = textController
              .clear(); //clear the text after clicking done from the search bar and it called from the TextFormfield
        }
      },
    );
  }

  // _getWeatherData(String location) async {
  //   WeatherModel response = await Api().getCurrentWeather(location);
  //   print(response.toJson());
  // }
}
