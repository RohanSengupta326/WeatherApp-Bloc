import 'package:bloc_weather_app/repository/weather_repository.dart';
import 'package:bloc_weather_app/theme/cubit/theme_cubit.dart';
import 'package:bloc_weather_app/weather/cubit/weather_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';

void main() {
  runApp(MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  final AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(),
      // for one instance of repository to be maintained throughout the widget tree
      // whereever in the widget tree this repo will be needed to call functions from or something,
      // here at the top , we will provide this single instance of WeatherRepository
      // to all the BlocProviders, so that one instance is used not multiple.
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubitCubit>(
            create: (ctx) => WeatherCubitCubit(
              weatherRepository: ctx.read<WeatherRepository>(),
              // sending already created instance of repository.
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (ctx) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, Color>(
          builder: (context, stateColor) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                    backgroundColor: stateColor.withAlpha(80),
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    )),
                colorScheme: ColorScheme.fromSeed(seedColor: stateColor),
              ),
              onGenerateRoute: appRoutes.onGeneratedRoute,
            );
          },
        ),
      ),
    );
  }
}
