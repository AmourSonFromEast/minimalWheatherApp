import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/service/weather_service.dart';

import '../models/Weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('288539170add564cfa0c8854abc72665');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rain.json';
      case 'Flash':
        return 'assets/Flash.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "loading city..",
              style: TextStyle(fontSize: 25),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round()}°С',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
