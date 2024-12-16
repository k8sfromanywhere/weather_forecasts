import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';
import 'package:weather_forecasts/data/helpers/weather_icon_helper.dart';
import 'package:weather_forecasts/presentation/widgets/sunrise_sunset_row.dart';
import 'package:weather_forecasts/presentation/widgets/temp_min_max_row.dart';

class WeatherContent extends StatelessWidget {
  final WeatherBlocSuccess state;

  const WeatherContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0,
          maxHeight: screenHeight * 0.95, // Ограничиваем высоту контента
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📍 ${state.weather.areaName}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Good Morning',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
                child: Center(
                    child:
                        getWeatherIcon(state.weather.weatherConditionCode!))),
            Center(
              child: Text(
                '${state.weather.temperature!.celsius!.round()}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                state.weather.weatherMain.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Center(
              child: Text(
                DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SunriseSunsetRow(state: state),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(color: Colors.grey),
            ),
            TempMinMaxRow(state: state),
          ],
        ),
      ),
    );
  }
}
