import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(ProviderScope(child: MyApp(isFirstLaunch: isFirstLaunch)));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isFirstLaunch ? HelpScreen() : HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://www.vhv.rs/dpng/d/427-4270068_gold-retro-decorative-frame-png-free-download-transparent.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We show weather for you',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToHome,
                child: Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _locationController = TextEditingController();
  String _temperature = '';
  String _condition = '';
  String _iconUrl = '';

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  void _loadLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('location');
    if (location != null) {
      _locationController.text = location;
      _fetchWeather(location);
    } else {
      _fetchWeatherByCurrentLocation();
    }
  }

  void _fetchWeather(String location) async {
    // Call weather API with location
    // Update _temperature, _condition, and _iconUrl with the response
  }

  void _fetchWeatherByCurrentLocation() async {
    // Call weather API with current latitude and longitude
    // Update _temperature, _condition, and _iconUrl with the response
  }

  void _saveLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', _locationController.text);
    _fetchWeather(_locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter location name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLocation,
              child: Text(_locationController.text.isEmpty ? 'Save' : 'Update'),
            ),
            SizedBox(height: 20),
            if (_temperature.isNotEmpty)
              Column(
                children: [
                  Text('Temperature: $_temperature°C'),
                  Text('Condition: $_condition'),
                  Image.network('https:$_iconUrl'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
