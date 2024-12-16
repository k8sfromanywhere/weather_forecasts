import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecasts/bloc/weather_bloc_bloc.dart';
import 'package:weather_forecasts/presentation/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Английский
        Locale('ru', ''), // Русский
      ],
      home: const LocationHandler(),
    );
  }
}

/// Виджет для работы с местоположением
class LocationHandler extends StatelessWidget {
  const LocationHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData?>(
      future: determinePosition(context),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snap.hasError) {
          debugPrint("Error in FutureBuilder: ${snap.error}");
          return Scaffold(
            body: Center(
              child: Text(
                'Ошибка: ${snap.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (snap.hasData) {
          return BlocProvider(
            create: (context) =>
                WeatherBlocBloc()..add(FetchWeatherFromLocation(snap.data!)),
            child: const HomeScreen(),
          );
        } else {
          debugPrint("Unexpected FutureBuilder state: ${snap.connectionState}");
          return const Scaffold(
            body: Center(child: Text("Не удалось получить данные")),
          );
        }
      },
    );
  }
}

/// Определение местоположения
Future<LocationData?> determinePosition(BuildContext context) async {
  final location = Location();

  try {
    await _checkLocationServices(context, location);
    await _checkAndRequestPermissions(context, location);
    final locationData = await location.getLocation();
    debugPrint("Location determined: $locationData");
    return locationData;
  } catch (e) {
    debugPrint("Error determining location: $e");
    return Future.error(e);
  }
}

/// Проверка и включение служб местоположения
Future<void> _checkLocationServices(
    BuildContext context, Location location) async {
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Местоположение отключено"),
          content: const Text(
            "Для работы приложения включите службы геолокации.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("ОК"),
            ),
          ],
        ),
      );
      throw 'Службы местоположения отключены.';
    }
  }
}

/// Проверка и запрос разрешений
Future<void> _checkAndRequestPermissions(
    BuildContext context, Location location) async {
  PermissionStatus permissionGranted = await location.hasPermission();

  if (permissionGranted == PermissionStatus.denied) {
    final requestPermission = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Необходимо разрешение"),
        content: const Text(
          "Приложению нужно разрешение на доступ к местоположению для его работы.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Отмена"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Разрешить"),
          ),
        ],
      ),
    );

    if (requestPermission == true) {
      permissionGranted = await location.requestPermission();
    } else {
      throw 'Разрешение на доступ к местоположению отклонено.';
    }
  }

  if (permissionGranted == PermissionStatus.deniedForever) {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Разрешение заблокировано"),
        content: const Text(
          "Разрешение на местоположение заблокировано. Вы можете изменить это в настройках устройства.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("ОК"),
          ),
        ],
      ),
    );
    throw 'Доступ к местоположению навсегда заблокирован.';
  }
}
