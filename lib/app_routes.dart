import '/weather/presentation/screens/weather_screen.dart';
import 'package:flutter/material.dart';

import 'search/search_screen.dart';
import 'settings/settings_page.dart';

class AppRoutes {
  Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => WeatherScreen(),
        );

      case '/search':
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (context) => SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => WeatherScreen(),
        );
    }
  }
}
