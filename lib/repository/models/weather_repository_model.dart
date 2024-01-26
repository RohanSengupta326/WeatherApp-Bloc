// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

class WeatherRepositoryModel {
  WeatherRepositoryModel({
    required this.location,
    required this.temperature,
    required this.weatherCondition,
  });

  final String location;
  final double temperature;
  final WeatherCondition weatherCondition;
}
