import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/model/air_pollution_model.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/widgets/parameter_card_widget.dart';
import 'package:weather_app/widgets/temp_condition_widget.dart';
import 'package:weather_app/widgets/weather_background_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String city = "Nuapada";

    Future<void> initData() async {
      await Provider.of<WeatherProvider>(context)
          .getLocationByCity(city);
      await Provider.of<WeatherProvider>(context, listen: false)
          .getAirPollutionData();

    }

    @override
    initState() {
      super.initState();
      initData();
    }

    return Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () async {
              await weatherProvider.getLocationByCity(city);
              await weatherProvider.getAirPollutionData();
            },
          ),
          body: FutureBuilder<WeatherModel>(
            future: weatherProvider.getWeatherData(),
            builder: (context, weatherSnapshot) {
              if (weatherSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (weatherSnapshot.hasError) {
                return Center(
                    child: Text('Error: ${weatherSnapshot.error}'));
              } else if (weatherSnapshot.hasData) {
                return FutureBuilder<CurrentWeatherModel>(
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
                            final weatherData = weatherSnapshot.data!;
                            final hourlyData = hourlySnapshot.data!;
                            final currentWeatherData = currentWeatherSnapshot.data!;
                            return Stack(
                              children: [
                                const WeatherBackgroundWidget(),
                                // Image.asset(
                                //   "assets/cloudy_weather.jpg",
                                //   fit: BoxFit.cover,
                                //   height: double.infinity,
                                //   width: double.infinity,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      TempConditionWidget(
                                        weatherData: weatherData,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      HourlyForecastWidget(
                                        weatherData: weatherData,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ParameterCardWidget(
                                            parameter: "Humidity",
                                            parameterImage: "assets/humidity.png",
                                            parameterValue:
                                            "${weatherData.current!.humidity.toString()}%",
                                          ),
                                          ParameterCardWidget(
                                            parameter: "AQI",
                                            parameterImage: "assets/aqi.png",
                                            parameterValue: weatherProvider
                                                .calculateAQIIndia(203.0, 'pm25'),
                                          ),
                                          ParameterCardWidget(
                                            parameter: "Wind",
                                            parameterImage: "assets/wind.png",
                                            parameterValue: "${weatherData.current!.windSpeed!.toInt().toString()} km/h",
                                          ),
                                        ],
                                      ),
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
                );
              }
              else{
                return const Center(child: Text('No data available'));
              }


            }
          ));
    });
  }
}
