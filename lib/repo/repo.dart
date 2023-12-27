import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/keys.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/hourly_forecast.dart';
import 'package:weather_app/model/location_model.dart';
import 'package:weather_app/model/weather_model.dart';

import '../model/air_pollution_model.dart';

Future<List<LocationModel>> getLocationByCityName(String city) async {
  try {
    final response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=3&appid=$API_KEY1"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<LocationModel> locations =
          jsonList.map((json) => LocationModel.fromJson(json)).toList();
      (locations.forEach((element) {
        print("${element.name}, ${element.state}, ${element.country}, ${element.lat}, ${element.lon}");
      }));
      return locations;
    } else {
      throw Exception('Failed to load location: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching location: $e');
    rethrow;
  }
}


Future<List<LocationModel>> getCityNameByLocation(double? lat, double? lon) async {
  try {
    final response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=3&appid=$API_KEY1"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<LocationModel> locations =
      jsonList.map((json) => LocationModel.fromJson(json)).toList();
      (locations.forEach((element) {
        print("${element.name}, ${element.state}, ${element.country}, ${element.lat}, ${element.lon}");
      }));
      return locations;
    } else {
      throw Exception('Failed to load location: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching location: $e');
    rethrow;
  }
}


Future<WeatherModel> getWeather(double? lat, double? lon) async {
  try{
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&units=metric&appid=$API_KEY2"),
    );
    if (response.statusCode == 200) {
      WeatherModel weatherModelDataResponse =
      WeatherModel.fromJson(jsonDecode(response.body));
      return weatherModelDataResponse;
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }

  } catch (e){
    print("error fetching weather: $e");
    rethrow;
  }
}

Future<CurrentWeatherModel> getCurrentWeather(double? lat, double? lon) async {
  try {
    print("Lat & Lon in extracting weather: $lat, $lon");
    final response = await http.post(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$API_KEY1"),
    );
    if (response.statusCode == 200) {
      CurrentWeatherModel currentWeatherDataResponse =
          CurrentWeatherModel.fromJson(jsonDecode(response.body));
      return currentWeatherDataResponse;
    } else {
      throw Exception('Failed to load current weather: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching current weather: $e');
    rethrow;
  }
}

Future<HourlyForecastModel> getHourlyForecast(double? lat, double? lon) async {
  try {
    final response = await http.post(
      Uri.parse(
          "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$lon&units=metric&cnt=12&appid=$API_KEY1"),
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
    rethrow;
  }
}

Future<AirPollutionModel> getAirPollution(double? lat, double? lon) async {
  try{
    final response = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&&appid=$API_KEY1"),
    );
    if (response.statusCode == 200) {
      AirPollutionModel airPollutionModel =
      AirPollutionModel.fromJson(jsonDecode(response.body));
      return airPollutionModel;
    } else {
      throw Exception('Failed to get air pollution data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching air pollution data: $e');
    rethrow;
  }
}
