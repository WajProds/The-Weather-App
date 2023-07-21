import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/services/location.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key, required var weather, required var place})
      : _weather = weather,
        _place = place;

  // ignore: prefer_typing_uninitialized_variables
  final _weather;
  // ignore: prefer_typing_uninitialized_variables
  final _place;
  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(36, 37, 52, 1),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          title: Text(
            widget._place,
            style: const TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: widget._weather != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "This week",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE').format(DateTime.now()
                                      .add(Duration(days: index + 1))),
                                  style: const TextStyle(
                                      color: Color.fromARGB(233, 255, 255, 255),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '${widget._weather["daily"]["temperature_2m_max"][index + 1]}°',
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${widget._weather["daily"]["temperature_2m_min"][index + 1]}°',
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              145, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        climateViewer(widget._weather, index),
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

String climateViewer(dynamic weather, int index) {
  int code = weather["daily"]["weathercode"][index + 1];
  if (code == 1 || code == 0) {
    return flatIcons['sun']!;
  } else if (code == 2 || code == 3) {
    return flatIcons['cloudy']!;
  } else if (code == 95 || code == 96 || code == 99) {
    return flatIcons['storm']!;
  } else {
    return flatIcons['rain']!;
  }
}
