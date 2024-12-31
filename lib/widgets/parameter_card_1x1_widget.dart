import 'dart:ui';
import 'package:flutter/material.dart';

class ParameterCard1x1Widget extends StatelessWidget {
  final String parameter;
  final String parameterImage;
  final String parameterValue;
  const ParameterCard1x1Widget({
    super.key,
    required this.parameter,
    required this.parameterImage,
    required this.parameterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
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
                const SizedBox(
                  height: 5,
                ),
                Image.asset(
                  parameterImage,
                  height: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  parameterValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
