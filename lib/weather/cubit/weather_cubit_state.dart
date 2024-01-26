// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@immutable
class WeatherCubitState extends Equatable {
  final WeatherStatus status;
  final WeatherStateModel weatherStateModel;
  final TemperatureUnits temperatureUnits;
  WeatherCubitState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celcius,
    // this.weatherStateModel = WeatherStateModel.empty,
    // cant do like this cause : The default value of an optional parameter must be
    // constant. Hence :
    WeatherStateModel? nullWeatherStateModel,
  }) : weatherStateModel = nullWeatherStateModel ?? WeatherStateModel.empty;

  WeatherCubitState copyWith({
    WeatherStatus? status,
    WeatherStateModel? weatherStateModel,
    TemperatureUnits? temperatureUnits,
  }) {
    return WeatherCubitState(
      status: status ?? this.status,
      nullWeatherStateModel: weatherStateModel ?? this.weatherStateModel,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, weatherStateModel, temperatureUnits];
}
