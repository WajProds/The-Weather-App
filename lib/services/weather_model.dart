import 'package:weather_app/services/permission.dart';

// import 'location.dart';

class WeatherModel {
  double temperature = 0.0;
  double windspeed = 0.0;
  int humidity = 0;
  int weathercode = 0;
  int isDay = 0; //0 = night , 1 = day

  WeatherModel({
    required this.temperature,
    required this.windspeed,
    required this.humidity,
    required this.weathercode,
    required this.isDay,
  });
}

Future<dynamic> getLocationWeather() async {
  // Location location = Location();
  PermissionService permission = PermissionService();
  permission.initLocationService();
  // location.getCurrentLocation();
  // location.fetchWeather();
}
