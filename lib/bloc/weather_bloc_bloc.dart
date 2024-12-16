import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecasts/data/data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeatherFromLocation>(_onFetchWeatherFromLocation);
    on<FetchWeatherByCity>(_onFetchWeatherByCity);
  }

  Future<void> _onFetchWeatherFromLocation(
      FetchWeatherFromLocation event, Emitter<WeatherBlocState> emit) async {
    emit(WeatherBlocLoading());
    try {
      final WeatherFactory weatherFactory =
          WeatherFactory(WEATHER_KEY, language: Language.ENGLISH);

      final Weather weather = await weatherFactory.currentWeatherByLocation(
        event.locationData.latitude!,
        event.locationData.longitude!,
      );

      emit(WeatherBlocSuccess(weather));
    } catch (e) {
      emit(WeatherBlocFailure());
    }
  }

  Future<void> _onFetchWeatherByCity(
      FetchWeatherByCity event, Emitter<WeatherBlocState> emit) async {
    emit(WeatherBlocLoading());
    try {
      final WeatherFactory weatherFactory =
          WeatherFactory(WEATHER_KEY, language: Language.ENGLISH);

      final Weather weather =
          await weatherFactory.currentWeatherByCityName(event.cityName);

      emit(WeatherBlocSuccess(weather));
    } catch (e) {
      emit(WeatherBlocFailure());
    }
  }
}
