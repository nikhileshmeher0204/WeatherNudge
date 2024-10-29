import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String? userInputCity = "";
  int? AQI;
  String? AQIInsight;
  String? weatherBackground;


  // WeatherModel? _weatherData;
  //
  // WeatherModel? get weatherData => _weatherData;
  //
  // WeatherProvider() {
  //   loadWeatherData(); // Load saved data on initialization
  // }
  //
  // Future<void> loadWeatherData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userInputCity = prefs.getString('userInputCity') ?? "";
  //   if (userInputCity != null && userInputCity!.isNotEmpty) {
  //     await getWeatherForCity(userInputCity!);
  //   }
  //   notifyListeners();
  // }
  //
  // Future<void> saveWeatherDataLocally() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userInputCity', userInputCity ?? "");
  //   if (_weatherData != null) {
  //     // Assuming _weatherData has a toJson method to serialize it
  //     await prefs.setString('weatherData', _weatherData!.toJson() as String);
  //   }
  // }

  // Future<LocationModel> getLocationByCity(String city) async {
  //   List<LocationModel> locations = await getLocationByCityName(city);
  //   lat = locations.first.lat;
  //   lon = locations.first.lon;
  //   _city = city;
  //   print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
  //   return locations.first;
  // }

  // Future<LocationModel> getCityByLocation() async {
  //   await _determinePosition();
  //   List<LocationModel> locations = await getCityNameByLocation(lat, lon);
  //   _city = locations.first.name!;
  //   print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
  //   return locations.first;
  // }

  Future<LocationModel> getWeatherForCity(String userInputCity) async {
    if (userInputCity!.isEmpty) {
      await _determinePosition();
      List<LocationModel> locations = await getCityNameByLocation(lat, lon);
      _city = locations.first.name!;
      print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
      return locations.first;
    } else {
      List<LocationModel> locations =
          await getLocationByCityName(userInputCity!);
      lat = locations.first.lat;
      lon = locations.first.lon;
      _city = userInputCity;
      print("Selected: ${locations.first.name}, lon: $lat, lon: $lon");
      return locations.first;
    }
  }

  Future<void> updateCityAndFetchWeather() async {
    //await saveWeatherDataLocally();
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
      print("lat: $lat, Lon: $lon");
    });
  }

  Future<WeatherModel> getWeatherData() async {
    print("extracting weather...!!!!!!!!!!!!!!");
    WeatherModel weatherData = await getWeather(lat, lon);
    await getWeatherBackground(weatherData.current!.weather!.first.main);
    print("weather background in getWeatherData(): $weatherBackground");
    await getAirPollutionData();
    //await saveWeatherDataLocally();
    return weatherData;
  }

  Future<CurrentWeatherModel> getCurrentWeatherData() async {
    print("extracting weather...");
    CurrentWeatherModel weatherData = await getCurrentWeather(lat, lon);
    //await saveWeatherDataLocally();

    return weatherData;
  }

  Future<HourlyForecastModel?> getHourlyForecastData() async {
    HourlyForecastModel? hourlyForecast = await getHourlyForecast(lat, lon);
    print("City: ${hourlyForecast.city!.name}");
    return hourlyForecast;
  }

  Future<AirPollutionModel?> getAirPollutionData() async {
    AirPollutionModel? airPollutionModel = await getAirPollution(lat, lon);
    AQI = calculateAQIIndia(
        airPollutionModel.list!.first.components!.pm25, 'pm25');
    if (AQI != null) {
      if (AQI! <= 50) {
        AQIInsight = "Good";
      } else if (AQI! > 51 && AQI! <= 100) {
        AQIInsight = "Moderate";
      } else if (AQI! > 101 && AQI! <= 200) {
        AQIInsight = "Poor";
      } else if (AQI! > 201 && AQI! <= 300) {
        AQIInsight = "Unhealthy";
      } else if (AQI! > 301 && AQI! <= 400) {
        AQIInsight = "Unhealthy";
      } else {
        AQIInsight = "Severe";
      }
    } else {
      AQIInsight = "Unknown";
    }

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
        return ((iHigh - iLow) / (cHigh - cLow) * (concentration - cLow) + iLow)
            .round();
      }
    }

    throw StateError('Failed to calculate AQI');
  }

  Future<void> getWeatherBackground(String? weather) async {
    try {
      if (weather != null) {
        weather = weather.trim(); // Trim leading and trailing spaces

        DateTime now = DateTime.now();
        int currentHour = now.hour;
        const int dayStartHour = 6;
        const int morningEndHour = 9;
        const int eveningHour = 17;
        const int nightStartHour = 18;
        print("Weather: $weather");
        print("Current hour: $currentHour");

        if (weather == "Clear" || weather == "Clouds") {
          print("weather==Clouds");
          if (currentHour >= dayStartHour && currentHour < morningEndHour) {
            weatherBackground = "assets/cloudy_morning.mp4";
            print("Setting background to cloudy morning");
          } else if (currentHour >= morningEndHour &&
              currentHour < eveningHour) {
            weatherBackground = "assets/moving_clouds.mp4";
            print("Setting background to moving clouds");
          } else if (currentHour >= eveningHour &&
              currentHour < nightStartHour) {
            weatherBackground = "assets/evening.mp4";
            print("Setting background to evening");
          }  else if (currentHour >= nightStartHour && currentHour<=24) {
            weatherBackground = "assets/night_moon.mp4";
            print("Setting background to night moon");
          } else {
            weatherBackground = "assets/moving_clouds.mp4";
            print("Setting background to moving clouds");
          }
        } else if (weather == "Rain" || weather == "Drizzle") {
          weatherBackground = "assets/light_rain.mp4";
          print("Setting background to light rain");
        } else if (weather == "Thunderstorm") {
          weatherBackground = "assets/thunderstorm.mp4";
          print("Setting background to thunderstorm");
        } else {
          weatherBackground = "assets/moving_clouds.mp4";
          print("Setting background to moving clouds");
        }
      } else {
        print("Weather is null!");
      }
    } catch (e, stackTrace) {
      print("Error in getWeatherBackground: $e");
      print(stackTrace);
    }

    print("Final weather background: $weatherBackground");
  }

  bool isDaytimeNow() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    // You may adjust the threshold based on your preference for day and night
    const int dayStartHour = 6;
    const int nightStartHour = 18;

    return currentHour >= dayStartHour && currentHour < nightStartHour;
  }
}
