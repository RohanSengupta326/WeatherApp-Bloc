import '../../../repository/models/weather_repository_model.dart';
import '../../models/weather_state_model.dart';
import 'package:flutter/material.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final WeatherStateModel weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _WeatherBackground(),
        RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: onRefresh,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    Text(
                      weather.location,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _WeatherIcon(
                          condition: weather.weatherCondition,
                          is_day: weather.is_day,
                        ),
                        Text(
                          weather.formattedTemperature(units),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  _WeatherIcon({
    required this.condition,
    required this.is_day,
  });

  static const _iconSize = 60.0;

  final WeatherCondition condition;
  final int is_day;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji(is_day, condition),
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  String toEmoji(int is_day, WeatherCondition weatherCondition) {
    if (weatherCondition == WeatherCondition.clear && is_day == 1) {
      return '☀️';
    } else if (weatherCondition == WeatherCondition.clear && is_day == 0) {
      return '🌙';
    } else if (weatherCondition == WeatherCondition.rainy) {
      return '🌧️';
    } else if (weatherCondition == WeatherCondition.cloudy) {
      return '☁️';
    } else if (weatherCondition == WeatherCondition.snowy) {
      return '🌨️';
    } else {
      return '❓';
    }
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    // print('############   PRIMARY COLOR : $primaryColor   #############\n\n');

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // border: Border.all(width: 5, color: Colors.purple),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // at 25% it will take primary color
            // at 75% screen, it will take primarycolor's 10% brightness
            // and so on.
            stops: const [0.25, 0.75, 0.90, 1],
            colors: [
              primaryColor,
              primaryColor.brighten(),
              primaryColor.brighten(33),
              primaryColor.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    // if condition is false assert , gives error.
    assert(
      (percent >= 1) && (percent <= 100),
      'percentage must be between 1 and 100',
    );
    // brightness chaning based on percentage, meaning adjusting rgb values.
    // based on brightness factor.
    final p = percent / 100;
    return Color.fromARGB(
      255,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

extension on WeatherStateModel {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.toStringAsPrecision(2)}°${units.isCelcius ? 'C' : 'F'}''';
  }
}
