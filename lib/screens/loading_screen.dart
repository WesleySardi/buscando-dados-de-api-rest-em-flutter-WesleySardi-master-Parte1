import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tempo_template/services/location.dart';
import 'package:tempo_template/services/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import '../services/weather.dart';
import 'location_screen.dart';

const apiKey = 'c7e803ecb444bf521ed5e2b74a9f7aa6';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }

  void getData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    pushToLocationScreen(weatherData);
  }

  Future<void> getLocation() async {
    var location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
