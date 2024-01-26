// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_weather_app/repository/models/weather_repository_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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

  WeatherStateModel({
    required this.temperature,
    required this.weatherCondition,
    required this.lastUpdated,
    required this.location,
  });

  factory WeatherStateModel.fromWeatherRespository(
      WeatherRepositoryModel weatherRepositoryModel) {
    return WeatherStateModel(
      temperature: weatherRepositoryModel.temperature,
      weatherCondition: weatherRepositoryModel.weatherCondition,
      lastUpdated: DateTime.now(),
      location: weatherRepositoryModel.location,
    );
  }

  static final WeatherStateModel empty = WeatherStateModel(
    temperature: 0,
    weatherCondition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    location: '--',
  );

  WeatherStateModel copyWith({
    double? temperature,
    WeatherCondition? weatherCondition,
    DateTime? lastUpdated,
    String? location,
  }) {
    return WeatherStateModel(
      temperature: temperature ?? this.temperature,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        temperature,
        weatherCondition,
        lastUpdated,
        location,
      ];
}
