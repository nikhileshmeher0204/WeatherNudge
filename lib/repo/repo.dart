import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/keys.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';



Future<CurrentWeatherModel> getCurrentWeather() async {
  final response = await http.post(
    Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&units=metric&appid=$API_KEY"),
  );
  CurrentWeatherModel currentWeatherDataResponse =
      CurrentWeatherModel.fromJson(jsonDecode(response.body));
  return currentWeatherDataResponse;
}



Future<HourlyForecastModel> getHourlyForecast() async {
  try {
    final response = await http.post(
      Uri.parse(
          "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=44.34&lon=10.99&units=metric&cnt=12&appid=$API_KEY"),
    );

    if (response.statusCode == 200) {
      HourlyForecastModel hourlyForecast =
      HourlyForecastModel.fromJson(jsonDecode(response.body));
      return hourlyForecast;
    } else {
      throw Exception('Failed to load hourly forecast: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching hourly forecast: $e');
    rethrow; // Rethrow the caught error for higher-level handling
  }
}