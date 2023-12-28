import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/conversion.dart';
import 'package:weather_app/model/weather_model.dart';

class DailyForecastWidget extends StatelessWidget {
  final WeatherModel weatherData;
  const DailyForecastWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WEEKLY FORECAST",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Divider(color: Colors.white24, ),
                    Column(
                        children: weatherData.daily!.map((e) {
                      return Row(
                        children: [
                          Text(
                      (weatherData.daily!.indexOf(e) == 0)
                          ? 'Today'
                              : (weatherData.daily!.indexOf(e) == 1)
                          ? 'Tomorrow'
                              : unixToITCDay(e.dt!.toInt()),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(child: Container()),
                          Column(
                            children: e.weather!.map((weather) {
                              return Image.asset("assets/${weather.icon}.png",
                                  height: 30);
                            }).toList(),
                          ),
                          const SizedBox(width: 40,),
                          Text(
                            "${e.temp!.min!.toInt()}°/${e.temp!.max!.toInt()}°",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 20,),
                          Image.asset("assets/precipitation_drop.png", height: 15,),
                          Text(
                            " ${e.pop! * 100.toInt()}%",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    }).toList()),
                  ],
                ))),
      ),
    );
  }
}
