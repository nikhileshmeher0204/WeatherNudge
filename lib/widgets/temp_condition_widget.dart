import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

import '../model/current_weather_data.dart';
import '../model/hourly_forecast.dart';
import '../model/weather_model.dart';

class TempConditionWidget extends StatelessWidget {
  final WeatherModel weatherData;
  const TempConditionWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    print("Lat:${weatherProvider.lat}, Lon:${weatherProvider.lon}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weatherProvider.cityName() ?? "",
          style: const TextStyle(
              fontSize: 45, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${weatherData.current!.temp!.toInt().toString()}°",
          style: const TextStyle(
              fontSize: 90,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            fontFamily: 'Poppins'
          ),
        ),
        Text(
          weatherData
              .current!.weather!.first.description!,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,),
        ),
      ],
    );
  }
}
