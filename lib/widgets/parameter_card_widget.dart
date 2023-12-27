import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_data.dart';

class ParameterCardWidget extends StatelessWidget {
  final parameter;
  final parameterImage;
  final parameterValue;
  const ParameterCardWidget({
    super.key,
    this.parameter,
    this.parameterImage,
    this.parameterValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  parameter,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5,),
                Image.asset(
                  parameterImage,
                  height: 40,
                ),
                const SizedBox(height: 5,),
                Text(
                  "$parameterValue",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}