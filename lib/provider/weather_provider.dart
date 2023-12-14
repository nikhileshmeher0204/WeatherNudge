import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/repo/repo.dart';
import '../model/hourly_forecast.dart';

class WeatherProvider extends ChangeNotifier{


    Future<CurrentWeatherModel> getCurrentWeatherData() async{
      CurrentWeatherModel weatherData = await getCurrentWeather();
      return weatherData;
    }

    Future<HourlyForecastModel?> getHourlyForecastData() async {
        HourlyForecastModel? hourlyForecast = await getHourlyForecast();
      return hourlyForecast;
    }
}