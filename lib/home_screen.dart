import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/hourly_forecast_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
        //
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            weatherProvider.getCurrentWeatherData();
          },
        ),
        body: FutureBuilder<CurrentWeatherModel>(
          future: weatherProvider.getCurrentWeatherData(),
          builder: (context, currentWeatherSnapshot) {
            if (currentWeatherSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (currentWeatherSnapshot.hasError) {
              return Center(
                  child: Text('Error: ${currentWeatherSnapshot.error}'));
            } else if (currentWeatherSnapshot.hasData) {
              return FutureBuilder<HourlyForecastModel?>(
                future: weatherProvider.getHourlyForecastData(),
                builder: (context, hourlySnapshot) {
                  if (hourlySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (hourlySnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${hourlySnapshot.error}'));
                  } else if (hourlySnapshot.hasData) {
                    final hourlyData = hourlySnapshot.data!;
                    final currentWeatherData = currentWeatherSnapshot.data!;
                    return Stack(
                      children: [
                        Image.asset(
                          "assets/cloudy_weather.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentWeatherData.name ?? "",
                                      style: const TextStyle(
                                          fontSize: 50, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${currentWeatherData.main!.temp!.toInt().toString()}°",
                                      style: const TextStyle(
                                          fontSize: 90,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      currentWeatherData
                                          .weather!.first.description!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              HourlyForecastWidget(
                                  currentWeatherData: currentWeatherData,
                                  hourlyData: hourlyData),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text('No hourly forecast data available'));
                  }
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ));
  }
}
