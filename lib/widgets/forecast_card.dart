import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../constants/images.dart';

// ignore: must_be_immutable
class ForecastCard extends StatelessWidget {
  ForecastCard({
    super.key,
    required TabController controller,
    required weather,
  })  : _controller = controller,
        _weather = weather;

  final TabController _controller;
  // ignore: prefer_typing_uninitialized_variables, prefer_final_fields
  var _weather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        height: 300,
        alignment: Alignment.center,
        child: TabBarView(
          controller: _controller,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(53, 66, 66, 66),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          DateFormat('hh mm a').format(
                              DateTime.parse("2012-02-27 09:00:00")
                                  .add(Duration(hours: index))),
                          style: const TextStyle(
                              color: Color.fromARGB(205, 235, 235, 235),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: SimpleShadow(
                              color: const Color.fromARGB(175, 46, 46, 46),
                              opacity: 1,
                              sigma: 5,
                              offset: const Offset(0, 0),
                              child: Image.asset(
                                climateViewer(_weather, index, 0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${_weather["hourly"]["temperature_2m"][9 + index]}°',
                          style: const TextStyle(
                            color: Color.fromARGB(229, 231, 229, 229),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 2.0,
                                color: Color.fromARGB(56, 46, 46, 46),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(53, 66, 66, 66),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          DateFormat('hh mm a').format(
                              DateTime.parse("2012-02-27 09:00:00")
                                  .add(Duration(hours: index))),
                          style: const TextStyle(
                              color: Color.fromARGB(205, 235, 235, 235),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: SimpleShadow(
                              color: const Color.fromARGB(175, 46, 46, 46),
                              opacity: 1,
                              sigma: 5,
                              offset: const Offset(0, 0),
                              child: Image.asset(
                                climateViewer(_weather, index, 24),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${_weather["hourly"]["temperature_2m"][9 + 24 + index]}°',
                          style: const TextStyle(
                            color: Color.fromARGB(229, 231, 229, 229),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 2.0,
                                color: Color.fromARGB(56, 46, 46, 46),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(53, 66, 66, 66),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          DateFormat('hh mm a').format(
                              DateTime.parse("2012-02-27 09:00:00")
                                  .add(Duration(hours: index))),
                          style: const TextStyle(
                              color: Color.fromARGB(205, 235, 235, 235),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: SimpleShadow(
                              color: const Color.fromARGB(175, 46, 46, 46),
                              opacity: 1,
                              sigma: 5,
                              offset: const Offset(0, 0),
                              child: Image.asset(
                                climateViewer(_weather, index, 48),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${_weather["hourly"]["temperature_2m"][9 + 48 + index]}°',
                          style: const TextStyle(
                            color: Color.fromARGB(229, 231, 229, 229),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 2.0,
                                color: Color.fromARGB(56, 46, 46, 46),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String climateViewer(dynamic weather, int index, int day) {
  int code = weather["hourly"]["weathercode"][index + 9 + day];
  if (code == 1 || code == 0) {
    return images['sun']!;
  } else if (code == 2 || code == 3) {
    return images['cloudy']!;
  } else if (code == 95 || code == 96 || code == 99) {
    return images['storm']!;
  } else {
    return images['rainy_day']!;
  }
}
