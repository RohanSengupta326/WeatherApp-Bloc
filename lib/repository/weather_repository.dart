import 'dart:convert';

import '../data/models/weather.dart';

import '../data/models/location.dart';

import '../data/api_client.dart';

import 'models/weather_repository_model.dart';

class WeatherRepository {
  Future<WeatherRepositoryModel> fetchWeatherData(String city) async {
    final ApiClient apiClient = ApiClient();

    try {
      final Location locationResponse = await apiClient.locationSearch(city);
      final Weather weatherResponse = await apiClient.weatherSearch(
        locationResponse.latitude,
        locationResponse.longitude,
      );

      return WeatherRepositoryModel(
        location: locationResponse.name,
        temperature: weatherResponse.temperature,
        weatherCondition: weatherResponse.weatherCode.toInt().toCondition,
        // converting weatherCode int to WeatherCondition type with int extension below.
      );
    } catch (error) {
      throw error;
    }
  }
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.unknown;
    }
  }
}
