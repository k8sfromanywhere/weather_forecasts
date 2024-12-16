import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';
import 'package:weather_forecasts/presentation/widgets/background_circles.dart';
import 'package:weather_forecasts/presentation/widgets/weather_content.dart';
import 'package:weather_forecasts/presentation/screens/search_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              final cityName = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );

              if (cityName != null &&
                  cityName is String &&
                  cityName.isNotEmpty) {
                context
                    .read<WeatherBlocBloc>()
                    .add(FetchWeatherByCity(cityName));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Stack(
          children: [
            // Используем BackgroundCircles, адаптированный под высоту экрана
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
                      'Не удалось загрузить данные о погоде',
                      style: TextStyle(
                        color: Color.fromARGB(255, 222, 123, 116),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Неизвестное состояние',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
