import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import '../model/location_model.dart';
import '../model/weather_model.dart';

class TempConditionWidget extends StatelessWidget {
  final WeatherModel weatherData;
  final LocationModel locationData;
  const TempConditionWidget(
      {super.key, required this.weatherData, required this.locationData});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    print("Lat:${weatherProvider.lat}, Lon:${weatherProvider.lon}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (weatherProvider.userInputCity!.isEmpty)
              const Padding(
                padding: EdgeInsets.only(right: 5.0, top: 17),
                child: Icon(
                  CupertinoIcons.location_fill,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            Expanded(
              child: Text(
                locationData.name ?? "",
                style: const TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
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
              fontFamily: 'Poppins'),
        ),
        Text(
          weatherData.current!.weather!.first.description!,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
