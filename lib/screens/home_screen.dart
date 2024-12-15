import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';
import 'package:weather_forecasts/screens/widgets/background_circles.dart';
import 'package:weather_forecasts/screens/widgets/weather_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Stack(
          children: [
            const BackgroundCircles(),
            BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
              builder: (context, state) {
                if (state is WeatherBlocSuccess) {
                  return WeatherContent(state: state);
                } else if (state is WeatherBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherBlocFailure) {
                  return const Center(
                    child: Text(
                      'Failed to load weather data',
                      style:
                          TextStyle(color: Color.fromARGB(255, 222, 123, 116)),
                    ),
                  );
                } else {
                  return const Center(child: Text('Unexpected state'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
