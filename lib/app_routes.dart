import '/weather/presentation/screens/weather_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route? getRoutes(RouteSettings routeSettings) {
    switch (routeSettings) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => WeatherScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => WeatherScreen(),
        );
    }
  }
}
