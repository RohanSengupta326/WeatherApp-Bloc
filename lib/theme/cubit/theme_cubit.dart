import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/repository/models/weather_repository_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(defaultColor);

  static Color defaultColor = Color(0xff3444a0);

  void onWeatherChange(WeatherCondition? weatherCondition) {
    if (weatherCondition != null) {
      emit(weatherCondition.toColor);
    }
  }
}

extension on WeatherCondition {
  Color get toColor {
    switch (this) {
      case WeatherCondition.clear:
        return Color.fromARGB(255, 90, 115, 252);
      case WeatherCondition.snowy:
        return Color.fromARGB(255, 34, 208, 162);
      case WeatherCondition.cloudy:
        return Color.fromARGB(255, 17, 169, 224);
      case WeatherCondition.rainy:
        return Color.fromARGB(255, 240, 193, 37);
      case WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}
