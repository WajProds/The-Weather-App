import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/screens/forecast_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> city = [
    'San Francisco',
    'New York',
    'Karachi',
    'Lahore',
    'Sau Paulo',
    'Pattoki',
    'Islamabad',
    'Peshawar',
    'Antartica'
  ];
  late dynamic jsonList;
  TextEditingController textController = TextEditingController();
  int index = 0;
  Location location = Location();
  late dynamic _weather;
  WeatherModel? weather;
  late Timer periodicTimer;
  late dynamic place;
  late dynamic test;
  var coordinates = {
    "latitude": 0.0,
    "longitude": 0.0,
  };

  void fetcher() async {
    Location loc = await Location().getCurrentLocation();

    jsonList = await loc.fetchWeather(loc.latitude, loc.longitide);

    setState(() {
      _weather = jsonList;
    });
  }

  void testerr() async {
    Location loc = await Location().getCurrentLocation();

    jsonList = await loc.fetchWeather(
        coordinates["latitude"], coordinates["longitude"]);

    setState(() {
      _weather = jsonList;
      place = city[index];
    });
  }

  void cityName() async {
    Location loc = Location();
    var name = await loc.city();
    setState(() {
      place = name[0]["name"];
    });
  }

  void locFetcher() async {
    test = await Geocoder().fetchCoordinate(city[index]);
    setState(() {
      print(test);
      coordinates["latitude"] = test[0]["latitude"];
      coordinates["longitude"] = test[0]["longitude"];
      print(coordinates);
    });
  }

  late VideoPlayerController _controller;
  @override
  void initState() {
    cityName();
    getLocationWeather();
    fetcher();
    // periodicTimer = Timer.periodic(
    //   const Duration(minutes: 5),
    //   (timer) {
    //     if (mounted) {
    //       fetcher();
    //     }
    //   },
    // );
    _controller = VideoPlayerController.asset('assets/videos/night.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setPlaybackSpeed(0.5);
        _controller.setVolume(0);

        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    periodicTimer.cancel();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 3, vsync: this);
    if (_weather != null) {
      weather = WeatherModel(
          temperature: _weather["current_weather"]["temperature"],
          windspeed: _weather["current_weather"]['windspeed'],
          humidity: _weather["hourly"]["relativehumidity_2m"]
              [DateTime.now().hour],
          weathercode: _weather["current_weather"]["weathercode"],
          isDay: _weather["current_weather"]["is_day"]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor:
          // primaries[weather != null ? tempValidator(weather!.temperature) : 3],
          Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: const Icon(
        //   Icons.location_pin,
        //   color: Color.fromARGB(255, 201, 201, 201),
        // ),
        title: Row(
          children: [
            SizedBox(
              width: 120,
              child: TextButton(
                child: Text(
                  place != null ? place : 'Loading',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForecastScreen(
                            weather: _weather,
                            place: place,
                          )));
                },
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (index < city.length - 1) {
                    index++;
                  } else if (index == city.length - 1) {
                    index = 0;
                  }
                  locFetcher();
                  testerr();
                });
              },
              icon: const Icon(
                Icons.double_arrow_rounded,
                color: Color.fromARGB(255, 201, 201, 201),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(96, 69, 88, 97)),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: textController,
                showCursor: false,
                style: const TextStyle(
                    fontSize: 18, color: Colors.white, letterSpacing: 1),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  suffixIcon: SizedBox(
                    height: 5,
                    width: 5,
                    child: IconButton(
                        color: const Color.fromARGB(255, 201, 201, 201),
                        onPressed: () {
                          setState(() {
                            city.add(textController.text);
                            textController.text = '';
                            index = city.length - 1;
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 20,
                        )),
                  ),
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 9),
                ),
              ),
            )),
          ],
        ),
      ),
      body: weather != null
          ? Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: _controller.value.size?.width ?? 0,
                      height: _controller.value.size?.height ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 80, left: 9),
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => ForecastScreen(
                //                 weather: _weather,
                //                 place: place,
                //               )));
                //     },
                //     child: const Text(
                //       'Forecast',
                //       style: TextStyle(
                //           color: Color.fromARGB(255, 238, 236, 236),
                //           fontSize: 15),
                //     ),
                //   ),
                // ),
                WeatherScreen(
                    weather: weather,
                    controller: controller,
                    weather2: _weather),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
