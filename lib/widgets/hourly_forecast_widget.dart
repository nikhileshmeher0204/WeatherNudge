import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';

import '../model/weather_model.dart';

class HourlyForecastWidget extends StatelessWidget {
  final WeatherModel weatherData;
  const HourlyForecastWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Feels like ${weatherData.current!.feelsLike!.toInt().toString()}°       ",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    const TextSpan(
                      text: "↑",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text:
                          "${weatherData.daily!.first!.temp!.max!.toInt().toString()}° ",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    const TextSpan(
                      text: "↓",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text:
                          "${weatherData.daily!.first!.temp!.min!.toInt().toString()}°",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: 150,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: weatherData.hourly!.map((e) {
                      //DateTime dateTime = DateTime.parse(e.dtTxt!);
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(e.dt!.toInt()! * 1000);
                      //dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
                      // dateTime = dateTime.toLocal();
                      String formattedTime = DateFormat.jm().format(dateTime);
                      num precipitation = e.pop! * 100;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              formattedTime, // Display date/time or other relevant info
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: e.weather!.map((weather) {
                                return Image.asset("assets/${weather.icon}.png",
                                    height: 40);
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              " ${e!.temp!.toInt().toString()}°",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Image.asset("assets/precipitation_drop.png", height: 15,),
                                Text(
                                  " ${precipitation.toInt()}%",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
