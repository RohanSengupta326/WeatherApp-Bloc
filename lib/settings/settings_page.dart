import 'package:bloc_weather_app/weather/models/weather_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../weather/cubit/weather_cubit_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<WeatherCubitCubit, WeatherCubitState>(
            buildWhen: (previous, current) =>
                previous.temperatureUnits != current.temperatureUnits,
            builder: (context, state) {
              return ListTile(
                title: const Text('Show in Celsius : '),
                trailing: Switch(
                  value: state.temperatureUnits.isCelcius,
                  onChanged: (_) =>
                      context.read<WeatherCubitCubit>().toggleUnits(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
