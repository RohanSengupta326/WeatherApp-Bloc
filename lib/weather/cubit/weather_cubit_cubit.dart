import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/repository/weather_repository.dart';
import 'package:bloc_weather_app/weather/models/weather_state_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_cubit_state.dart';

class WeatherCubitCubit extends Cubit<WeatherCubitState> {
  WeatherCubitCubit({required this.weatherRepository})
      : super(WeatherCubitState());
  final WeatherRepository weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = WeatherStateModel.fromWeatherRespository(
        await weatherRepository.fetchWeatherData(city),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toCelsius()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherStateModel: weather.copyWith(
            temperature: value,
          ),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  //refresh weather
  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weatherStateModel == WeatherStateModel.empty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = WeatherStateModel.fromWeatherRespository(
        await weatherRepository
            .fetchWeatherData(state.weatherStateModel.location),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toCelsius()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weatherStateModel: weather.copyWith(
            temperature: value,
          ),
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  //toggle units
  Future<void> toggleUnits() async {
    if (!state.status.isSuccess) return;

    final units = state.temperatureUnits;
    final value = state.weatherStateModel;
    final temperatureValue = value.temperature;

    if (state.weatherStateModel != WeatherStateModel.empty) {
      final changedUnit = units.isFahrenheit
          ? TemperatureUnits.celcius
          : TemperatureUnits.fahrenheit;
      final changedTemperatureValue = units.isFahrenheit
          ? temperatureValue.toCelsius()
          : temperatureValue.toFahrenheit();

      emit(
        state.copyWith(
          temperatureUnits: changedUnit,
          weatherStateModel: value.copyWith(
            temperature: changedTemperatureValue,
          ),
        ),
      );
    }
  }
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}
