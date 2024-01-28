import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/repository/models/weather_repository_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(defaultColor);

  static const defaultColor = Colors.indigoAccent;

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
        return Colors.indigoAccent.shade700;
      case WeatherCondition.snowy:
        return Colors.indigoAccent.shade200;
      case WeatherCondition.cloudy:
        return Colors.indigoAccent.shade400;
      case WeatherCondition.rainy:
        return Colors.indigoAccent.shade700;
      case WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}
