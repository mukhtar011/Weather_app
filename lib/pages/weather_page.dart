import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  //api key
  final _weatherService = WeatherService('2130113de5d6152a7976b78a7655fc58');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {
      print(e);
    }
  }
  //weather animation
  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) return "assets/sunny.json";

  switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
        case 'smoke':
    case 'dust':
    case 'fog':
    case 'haze':
      return 'assets/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rain.json';
    case 'Thunderstorm':
      return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
    default:
      return 'assets/sunny.json';
  }
  }

  @override
  void initState(){
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //cityname
          Text(_weather?.cityName ?? "Loading City.."),

          //animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          //temperature
          Text('${_weather?.tempearture.round()}°C'),

          //animation
          Text(_weather?.mainCondition ?? ""),

        ],
      ),
    ),
    );
  }
}
