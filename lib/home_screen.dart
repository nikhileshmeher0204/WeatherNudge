import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/weekly_forecast_widget.dart';
import 'package:weather_app/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/widgets/insights_widget.dart';
import 'package:weather_app/widgets/parameter_card_1x1_widget.dart';
import 'package:weather_app/widgets/parameter_card_2x1_widget.dart';
import 'package:weather_app/widgets/temp_condition_widget.dart';
import 'package:weather_app/widgets/weather_background_widget.dart';
import 'conversion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        return Scaffold(
          body: FutureBuilder<LocationModel>(
              future: weatherProvider.getCityByLocation(),
              builder: (context, locationSnapshot) {
                if (locationSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (locationSnapshot.hasError) {
                  return Text('Error: ${locationSnapshot.error}');
                } else if (locationSnapshot.hasData) {
                  return FutureBuilder<WeatherModel>(
                      future: weatherProvider.getWeatherData(),
                      builder: (context, weatherSnapshot) {
                        if (weatherSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (weatherSnapshot.hasError) {
                          return Text('Error: ${weatherSnapshot.error}');
                        } else if (weatherSnapshot.hasData) {
                          final weatherData = weatherSnapshot.data!;
                          return Stack(
                            children: [
                              const WeatherBackgroundWidget(),
                              RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {});
                                  await Future.delayed(
                                      const Duration(seconds: 5));
                                },
                                child: CustomScrollView(
                                  physics: const ScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics())),
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 60,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
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
                                                    InsightsWidget(
                                                        weatherData:
                                                            weatherData),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ParameterCard1x1Widget(
                                                          parameter: "Humidity",
                                                          parameterImage:
                                                              "assets/humidity.png",
                                                          parameterValue:
                                                              "${weatherData.current!.humidity.toString()}%",
                                                        ),
                                                        ParameterCard1x1Widget(
                                                          parameter: "AQI",
                                                          parameterImage:
                                                              "assets/aqi.png",
                                                          parameterValue:
                                                              "${weatherProvider.AQI} ${weatherProvider.AQIInsight}",
                                                        ),
                                                        ParameterCard1x1Widget(
                                                          parameter: "Wind",
                                                          parameterImage:
                                                              "assets/wind.png",
                                                          parameterValue:
                                                              "${weatherData.current!.windSpeed!.toInt().toString()} km/h",
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        ParameterCard1x1Widget(
                                                          parameterValue:
                                                              uvIndex(
                                                                  weatherData
                                                                      .current!
                                                                      .uvi!),
                                                          parameterImage:
                                                              "assets/uv_index.png",
                                                          parameter: "UV Index",
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        ParameterCard2x1Widget(
                                                          parameter1: "Sunrise",
                                                          parameterImage1:
                                                              "assets/sunrise.png",
                                                          parameterValue1:
                                                              unixToITCTime(
                                                                  weatherData
                                                                      .current!
                                                                      .sunrise),
                                                          parameter2: "Sunset",
                                                          parameterImage2:
                                                              "assets/sunset.png",
                                                          parameterValue2:
                                                              unixToITCTime(
                                                                  weatherData
                                                                      .current!
                                                                      .sunset),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    WeeklyForecastWidget(
                                                        weatherData:
                                                            weatherData),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Text('No data available');
                        }
                      });
                } else {
                  return const Text('No data available');
                }
              }),
        );
      },
    );
  }
}
