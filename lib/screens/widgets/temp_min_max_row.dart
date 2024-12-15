import 'package:flutter/material.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';

class TempMinMaxRow extends StatelessWidget {
  final WeatherBlocSuccess state;

  const TempMinMaxRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoRow(
          image: 'assets/13.png',
          label: 'Temp Max',
          value: '${state.weather.tempMax!.celsius!.round()}°C',
        ),
        _buildInfoRow(
          image: 'assets/14.png',
          label: 'Temp Min',
          value: '${state.weather.tempMin!.celsius!.round()}°C',
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
