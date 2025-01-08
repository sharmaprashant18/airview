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

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
//   runApp(ProviderScope(child: Home(isFirstLaunch: isFirstLaunch)));
// }

// class Home extends StatelessWidget {
//   final bool isFirstLaunch;
//   const Home({super.key, required this.isFirstLaunch});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: isFirstLaunch ? HelpScreen() : WeatherScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HelpScreen extends StatefulWidget {
//   @override
//   _HelpScreenState createState() => _HelpScreenState();
// }

// class _HelpScreenState extends State<HelpScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       _navigateToHome();
//     });
//   }

//   void _navigateToHome() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isFirstLaunch', false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => WeatherScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/moru_background.png',
//             fit: BoxFit.contain,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'We show weather for you',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _navigateToHome,
//                 child: Text('Skip'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   TextEditingController _locationController = TextEditingController();
//   String _temperature = '';
//   String _condition = '';
//   String _iconUrl = '';
//   bool _isUpdating = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedLocation();
//   }

//   void _loadSavedLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedLocation = prefs.getString('location');
//     if (savedLocation != null) {
//       _locationController.text = savedLocation;
//       _fetchWeather(savedLocation);
//     } else {
//       _fetchWeatherByCurrentLocation();
//     }
//   }

//   void _fetchWeather(String location) async {
//     final response = await http.get(Uri.parse(
//         'http://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=$location'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         _temperature = '${data['current']['temp_c']} °C';
//         _condition = data['current']['condition']['text'];
//         _iconUrl = 'https:${data['current']['condition']['icon']}';
//       });
//     } else {
//       _showError();
//     }
//   }

//   void _fetchWeatherByCurrentLocation() async {
//     // Implement fetching weather by current location
//   }

//   void _showError() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to fetch weather data')),
//     );
//   }

//   void _saveLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('location', _locationController.text);
//     _fetchWeather(_locationController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.help),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HelpScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(labelText: 'Enter location'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _saveLocation,
//               child: Text(_locationController.text.isEmpty ? 'Save' : 'Update'),
//             ),
//             SizedBox(height: 20),
//             if (_temperature.isNotEmpty)
//               Column(
//                 children: [
//                   Text(
//                     _temperature,
//                     style: TextStyle(fontSize: 32),
//                   ),
//                   Text(
//                     _condition,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   Image.network(_iconUrl),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
