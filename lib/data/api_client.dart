import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'models/location.dart';
import 'models/weather.dart';

// Exceptions
class FetchLocationFailure implements Exception {}

class LocationNotFoundFailure implements Exception {}

class FetchWeatherFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}
//

// Data Fetch Class
class ApiClient {
  // http client
  final http.Client _httpClient = http.Client();

  // base urls
  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  Future<Location> locationSearch(String city) async {
    final Uri locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {
        'name': city,
        'count': '1',
      },
    );

    final Response locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw FetchLocationFailure();
    }

    final response = json.decode(locationResponse.body) as Map;

    if (!response.containsKey('results')) throw LocationNotFoundFailure();

    final results = response['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();
    // print('################${results.first} ################\n\n\n\n');
    return Location.fromMap(results.first as Map<String, dynamic>);
  }

  // fetch weather.
  Future<Weather> weatherSearch(double latitude, double longitude) async {
    final Uri weatherRequest = Uri.https(
      _baseUrlWeather,
      'v1/forecast',
      {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'current_weather': 'true',
      },
    );

    try {
      // print('######### calling HTTP GET ##########');
      final Response weatherResponse = await _httpClient.get(weatherRequest);
      // print('######### called HTTP GET ##########');

      if (weatherResponse.statusCode != 200) throw FetchWeatherFailure();

      final weatherResult = json.decode(weatherResponse.body) as Map;
      // print('############   decoded json   #############\n\n');

      if (!weatherResult.containsKey('current_weather')) {
        throw WeatherNotFoundFailure();
      }

      final finalWeatherResult = weatherResult['current_weather'] as Map;
      // print('############   fetched weatherResult   #############\n\n');
      // print('############   $finalWeatherResult   #############\n\n');
      if (finalWeatherResult.isEmpty) throw WeatherNotFoundFailure();
      // print('############   ${finalWeatherResult['temperature']}   #############\n\n');
      // print('############   ${finalWeatherResult['weathercode']}   #############\n\n');

      // print('############   sending to repository   #############\n\n');
      return Weather.fromMap(finalWeatherResult as Map<String, dynamic>);
    } catch (error) {
      print('############   Error in api client :   #############\n\n');
      print('############   $error   #############\n\n');
      throw FetchWeatherFailure();
    }
  }
}
