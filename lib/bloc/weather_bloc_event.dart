part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object?> get props => [];
}

final class FetchWeatherFromLocation extends WeatherBlocEvent {
  final LocationData locationData;

  const FetchWeatherFromLocation(this.locationData);

  @override
  List<Object?> get props => [locationData];
}

final class FetchWeatherByCity extends WeatherBlocEvent {
  final String cityName;

  const FetchWeatherByCity(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
