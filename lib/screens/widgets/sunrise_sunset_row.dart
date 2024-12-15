import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';

class SunriseSunsetRow extends StatelessWidget {
  final WeatherBlocSuccess state;

  const SunriseSunsetRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoRow(
          image: 'assets/11.png',
          label: 'Sunrise',
          value: DateFormat('').add_jm().format(state.weather.sunrise!),
        ),
        _buildInfoRow(
          image: 'assets/12.png',
          label: 'Sunset',
          value: DateFormat('').add_jm().format(state.weather.sunset!),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String image,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Image.asset(image, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
