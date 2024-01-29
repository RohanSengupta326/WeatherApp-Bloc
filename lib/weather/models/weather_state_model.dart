// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:bloc_weather_app/repository/models/weather_repository_model.dart';

enum TemperatureUnits { fahrenheit, celcius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelcius => this == TemperatureUnits.celcius;
}

class WeatherStateModel extends Equatable {
  final double temperature;
  final WeatherCondition weatherCondition;
  final DateTime lastUpdated;
  final String location;
  final int is_day;

  WeatherStateModel({
    required this.temperature,
    required this.weatherCondition,
    required this.lastUpdated,
    required this.location,
    required this.is_day,
  });

  factory WeatherStateModel.fromWeatherRespository(
      WeatherRepositoryModel weatherRepositoryModel) {
    return WeatherStateModel(
      temperature: weatherRepositoryModel.temperature,
      weatherCondition: weatherRepositoryModel.weatherCondition,
      lastUpdated: DateTime.now(),
      location: weatherRepositoryModel.location,
      is_day: weatherRepositoryModel.is_day,
    );
  }

  static final WeatherStateModel empty = WeatherStateModel(
    temperature: 0,
    weatherCondition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    location: '--',
    is_day: 0,
  );

  WeatherStateModel copyWith({
    double? temperature,
    WeatherCondition? weatherCondition,
    DateTime? lastUpdated,
    String? location,
    int? is_day,
  }) {
    return WeatherStateModel(
      temperature: temperature ?? this.temperature,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      is_day: is_day ?? this.is_day,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        temperature,
        weatherCondition,
        lastUpdated,
        location,
        is_day,
      ];
}
