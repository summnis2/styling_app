import 'package:flutter/cupertino.dart';

class WeatherModel {
  String? getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/images/weather/cloud-lightning.gif';
    } else if (condition < 400) {
      return 'assets/images/weather/구름-조금-비.gif';
    } else if (condition < 600) {
      return 'assets/images/weather/비.gif';
    } else if (condition < 700) {
      return 'assets/images/weather/눈.gif';
    } else if (condition < 800) {
      return 'assets/images/weather/fog.gif';
    } else //if (condition == 800) {
    {
      return 'assets/images/weather/태양.gif';
    }
  }

  String? getWeatherInfo(int condition) {
    if (condition < 300) {
      return '구름번개';
    } else if (condition < 400) {
      return '비구름';
    } else if (condition < 600) {
      return '비';
    } else if (condition < 700) {
      return '눈';
    } else if (condition < 800) {
      return '안개';
    } else //if (condition == 800) {
    {
      return '맑음';
    }
  }
}
