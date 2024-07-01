import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Clima extends StatefulWidget {
  @override
  _ClimaState createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  final String apiKey = 'c1dd3cb0eaa9482d144ca0316223addf';
  final String city = 'Santo Domingo';
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        setState(() {
          weatherData = null;
        });
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        weatherData = null;
      });
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: weatherData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Clima en $city',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${weatherData!['main']['temp']}°C',
                    style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(height: 20),
                  Text(
                    weatherData!['weather'][0]['description'],
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'http://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
                  ),
                ],
              ),
      ),
    );
  }
}
