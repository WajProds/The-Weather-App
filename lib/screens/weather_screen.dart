// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../constants/images.dart';
import '../services/weather_model.dart';
import '../widgets/forecast_card.dart';

// ignore: must_be_immutable
class WeatherScreen extends StatelessWidget {
  WeatherScreen({
    super.key,
    required this.weather,
    required TabController controller,
    required weather2,
  })  : _controller = controller,
        _weather = weather2;

  final WeatherModel? weather;
  final TabController _controller;
  // ignore: prefer_typing_uninitialized_variables
  var _weather;

  @override
  Widget build(BuildContext context) {
    return Column(
    
      children: [
        const SizedBox(
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 150,
            alignment: Alignment.topCenter,
            child: SimpleShadow(
              color: const Color.fromARGB(175, 46, 46, 46),
              opacity: 1,
              sigma: 5,
              offset: const Offset(0, 0),
              child: Image.asset(
                climateViewer(weather!),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${weather!.temperature}°",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(230, 255, 255, 255),
            fontSize: 60,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 5.0,
                color: Color.fromARGB(104, 166, 166, 166),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.air_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              "${weather!.windspeed} km/h",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(width: 20),
            const Icon(Icons.water_drop_outlined,
                size: 20, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              "${weather!.humidity} %",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TabBar(
            unselectedLabelColor: const Color.fromARGB(204, 174, 174, 174),
            indicatorColor: const Color.fromARGB(0, 255, 201, 201),
            labelColor: const Color.fromARGB(255, 255, 255, 255),
            controller: _controller,
            tabs: [
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                'Today' + DateFormat('  dd, MMM').format(DateTime.now()),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                DateFormat('EEE dd, MMM')
                    .format(DateTime.now().add(const Duration(days: 1))),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                DateFormat('EEE dd, MMM')
                    .format(DateTime.now().add(const Duration(days: 2))),
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        ForecastCard(controller: _controller, weather: _weather),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}

int tempValidator(double temp) {
  if (temp <= 4) {
    return 1;
  } else if (30 > temp || temp >= 5) {
    return 2;
  } else {
    return 3;
  }
}

String climateViewer(WeatherModel weather) {
  if (weather.weathercode == 1 || weather.weathercode == 0) {
    if (weather.isDay == 1) {
      return images['sun']!;
    } else {
      return images['night']!;
    }
  } else if (weather.weathercode == 2 || weather.weathercode == 3) {
    if (weather.isDay == 1) {
      return images['cloudy']!;
    } else {
      return images['nightcloud']!;
    }
  } else if (weather.weathercode == 95 ||
      weather.weathercode == 96 ||
      weather.weathercode == 99) {
    return images['storm']!;
  } else {
    return images['rainy_day']!;
  }
}
