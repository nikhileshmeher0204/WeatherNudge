import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';

class HourlyForecastWidget extends StatelessWidget {
  final CurrentWeatherModel currentWeatherData;
  final HourlyForecastModel hourlyData;
  const HourlyForecastWidget({
    super.key,
    required this.currentWeatherData,
    required this.hourlyData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                          "Feels like ${currentWeatherData.main!.feelsLike!.toInt().toString()}°       ",
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
                          "${currentWeatherData.main!.tempMax!.toInt().toString()}° ",
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
                          "${currentWeatherData.main!.tempMin!.toInt().toString()}°",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: 135,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: hourlyData.list!.map((e) {
                      DateTime dateTime = DateTime.parse(e.dtTxt!);
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
                              " ${e.main!.temp!.toInt().toString()}°",
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
