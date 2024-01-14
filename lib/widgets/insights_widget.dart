import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class InsightsWidget extends StatelessWidget {
  final WeatherModel weatherData;
  const InsightsWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "INSIGHTS",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(color: Colors.white24,),
                Text(
                  "• ${weatherData.daily!.first.summary}",
                  style: const TextStyle(
                       color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
