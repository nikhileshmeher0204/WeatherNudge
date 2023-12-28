import 'dart:ui';

import 'package:flutter/material.dart';

class ParameterCard2x1Widget extends StatelessWidget {
  final String parameter1;
  final String parameterImage1;
  final String parameterValue1;
  final String parameter2;
  final String parameterImage2;
  final String parameterValue2;
  const ParameterCard2x1Widget({
    super.key,
    required this.parameter1,
    required this.parameterImage1,
    required this.parameterValue1,
    required this.parameter2,
    required this.parameterImage2,
    required this.parameterValue2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 245,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      parameter1,
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
                      parameterImage1,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      parameterValue1,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Column(
                  children: [
                    Text(
                      parameter2,
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
                      parameterImage2,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      parameterValue2,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
