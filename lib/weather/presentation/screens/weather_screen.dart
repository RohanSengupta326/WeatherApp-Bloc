import 'package:bloc_weather_app/theme/cubit/theme_cubit.dart';

import '../../cubit/weather_cubit_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/weather_empty.dart';
import '../widgets/weather_error.dart';
import '../widgets/weather_loading.dart';
import '../widgets/weather_populated.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Bloc-WeatherApp',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/settings'
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubitCubit, WeatherCubitState>(
          // to call change theme in ThemeCubit. and reflect in MaterialApp theme.
          listener:
              (BuildContext buildContext, WeatherCubitState weatherCubitState) {
            // print('############   CALLING THEMECHANGE   #############\n\n');
            if (weatherCubitState.status.isSuccess) {
              buildContext.read<ThemeCubit>().onWeatherChange(
                  weatherCubitState.weatherStateModel.weatherCondition);
            }
          },
          builder: (context, state) {
            // print('############   REBUILDING MAIN SCREEN   #############\n\n');
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weatherStateModel,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubitCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).pushNamed('/search');
          if (!mounted) return;
          await context.read<WeatherCubitCubit>().fetchWeather(city as String);
        },
      ),
    );
  }
}
