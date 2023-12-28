import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repo/repo.dart';
import '../model/air_pollution_model.dart';
import '../model/hourly_forecast.dart';
import '../model/location_model.dart';

class WeatherProvider extends ChangeNotifier {
  double? lat;
  double? lon;
  String? _city;
  cityName() => _city;
  int? AQI;


  Future<LocationModel> getLocationByCity(String city) async{
    List<LocationModel> locations = await getLocationByCityName(city);
    lat = locations.first.lat;
    lon = locations.first.lon;
    _city = city;
    print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
    return locations.first;
    notifyListeners();
  }
  getCityByLocation(double? lat, double? lon) async{
    List<LocationModel> locations = await getCityNameByLocation(lat, lon);
    _city = locations.first.name!;
    print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
    notifyListeners();
  }


   _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      lon = value.longitude;
      getCityByLocation(lat, lon);
      notifyListeners();
      print("lat: $lat, Lon: $lon");
    });
  }

  determinePosition() => _determinePosition();



  Future<WeatherModel> getWeatherData() async {
    print("extracting weather...");
    WeatherModel weatherData =
    await getWeather(lat, lon);
    await getAirPollutionData();
    return weatherData;
  }


  Future<CurrentWeatherModel> getCurrentWeatherData() async {
    print("extracting weather...");
    CurrentWeatherModel weatherData =
        await getCurrentWeather(lat, lon);
    return weatherData;
  }

  Future<HourlyForecastModel?> getHourlyForecastData() async {
    HourlyForecastModel? hourlyForecast = await getHourlyForecast(lat, lon);
    print("City: ${hourlyForecast.city!.name}");
    return hourlyForecast;
  }

  Future<AirPollutionModel?> getAirPollutionData() async{
    AirPollutionModel? airPollutionModel = await getAirPollution(lat, lon);
    AQI = calculateAQIIndia(airPollutionModel.list!.first.components!.pm25, 'pm25');
    return airPollutionModel;
  }



  int calculateAQIIndia(num? concentration, String pollutant) {
    // Define AQI breakpoints and indices for India
    Map<String, List<int>> aqiBreakpoints = {
      'pm25': [0, 35, 75, 115, 150, 250, 350, 500],
      // 'pm10': [0, 50, 100, 250, 350, 430],
      // 'o3': [0, 50, 100, 168, 208, 748],
      // Add breakpoints for other pollutants as needed
    };

    // Check if the pollutant is supported
    if (!aqiBreakpoints.containsKey(pollutant)) {
      throw ArgumentError('Unsupported pollutant: $pollutant');
    }

    // Retrieve AQI breakpoints for the specified pollutant
    List<int> breakpoints = aqiBreakpoints[pollutant]!;

    // Calculate AQI using the formula
    int aqi = _calculateAQI(concentration, breakpoints);

    return aqi;
  }

  int _calculateAQI(num? concentration, List<int> breakpoints) {
    if (concentration! < breakpoints[0] || concentration > breakpoints.last) {
      throw ArgumentError('Concentration value out of range');
    }

    for (int i = 1; i < breakpoints.length; i++) {
      if (concentration <= breakpoints[i]) {
        double cLow = breakpoints[i - 1].toDouble();
        double cHigh = breakpoints[i].toDouble();
        double iLow = (i - 1) * 50.0;
        double iHigh = i * 50.0;

        // Apply the AQI formula
        return ((iHigh - iLow) / (cHigh - cLow) * (concentration - cLow) + iLow).round();
      }
    }

    throw StateError('Failed to calculate AQI');
  }

}