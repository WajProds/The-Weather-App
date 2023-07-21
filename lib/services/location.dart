import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Location {
  String apiKey = 'your API key';
  int status = 0;
  double latitude = 0.0;
  double longitide = 0.0;

  Future<Location> getCurrentLocation() async {
    Location location = Location();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitide = position.longitude;

    location.latitude = latitude;
    location.longitide = longitide;
    return location;
  }

  fetchWeather(latitude, longitude) async {
    String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String endDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 10)));
    final dio = Dio();

    String url = "https://api.open-meteo.com/v1/forecast?";

    Map<String, dynamic> queryParams = {
      "latitude": latitude,
      "longitude": longitude,
      "current_weather": true,
      "hourly": "relativehumidity_2m,temperature_2m,weathercode",
      "timezone": "auto",
      "daily": "weathercode,temperature_2m_max,temperature_2m_min",
      "forecast_days": "3",
      "start_date": startDate,
      "end_date": endDate
    };

    try {
      var response = await dio.get(url, queryParameters: queryParams);

      if (response.statusCode == 200) {
        return response.data as Map;
      } else {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
    } catch (e) {
      Center(child: Text(e.toString()));
    }
  }

  city() async {
    Location loc = await getCurrentLocation();
    final dio = Dio();
    Map<String, String> headers = {
      "X-Api-Key": "yxtMfJRw1MBJHmidNdxpFw==2BFR3tGYYolMlX1k"
    };
    String url = "https://api.api-ninjas.com/v1/reversegeocoding?";
    Map<String, dynamic> queryParams = {
      "lat": loc.latitude,
      "lon": loc.longitide,
    };
    try {
      var response = await dio.get(url,
          queryParameters: queryParams, options: Options(headers: headers));

      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
    } catch (e) {
      Center(
        child: Text(e.toString()),
      );
    }
  }
}

class Geocoder {
  String city = '';
  Map<String, String> headers = {
    "X-Api-Key": "yxtMfJRw1MBJHmidNdxpFw==2BFR3tGYYolMlX1k"
  };
  String url = "https://api.api-ninjas.com/v1/geocoding?";

  fetchCoordinate(String city) async {
    final dio = Dio();
    Map<String, String> queryParams = {
      "city": city,
    };

    try {
      var response = await dio.get(url,
          queryParameters: queryParams, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        const Center(
          child: CircularProgressIndicator(),
        );
      }
    } catch (e) {
      Center(
        child: Text(e.toString()),
      );
    }
  }
}
