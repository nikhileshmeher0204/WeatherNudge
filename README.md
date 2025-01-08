# WeatherNudge ☁️⛅️

A modern Flutter weather application that provides real-time weather information with beautiful dynamic backgrounds based on current weather conditions and time of day.

## Features 🌍

- ⏳ Real-time weather data
- 🎥 Dynamic video backgrounds based on weather conditions
- 🕒 Hourly and weekly forecasts
- 📊 Air quality index (AQI) monitoring
- 📍 Location-based weather updates
- 🔍 Search functionality for different locations
- ⏰ Time-aware UI (changes based on location's current time)

## Tech Stack 🛠️

- Flutter
- Provider (State Management)
- OpenWeatherMap API
- Geolocator
- Custom platform channels for video backgrounds

## Setup 🔧

1. Clone the repository

```bash
git clone https://github.com/nikhileshmeher0204/weather_app.git
```

2. Create a `.env` file in the root directory:

```properties
API_KEY1=your_openweathermap_api_key
API_KEY2=your_One_Call_API_3.0_api_key
```

3. Install dependencies

```bash
flutter clean
flutter pub get
```

4. Run the app

```bash
flutter run --no-enable-impeller
```

## Environment Setup 🎤

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
- Android SDK: min 21
- iOS: min 11.0

## Dependencies 📢

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  geolocator: ^10.0.0
  http: ^1.1.0
  flutter_dotenv: ^5.0.2
fonts:
   - family: Poppins
     fonts:
       - asset: assets/fonts/Poppins-Regular.ttf
       - asset: assets/fonts/Poppins-Medium.ttf
       - asset: assets/fonts/Poppins-ExtraLight.ttf
       - asset: assets/fonts/Poppins-SemiBold.ttf
```

## Recordings 🎥

https://github.com/user-attachments/assets/f553940f-4424-4e58-9a37-32e0545aa5c7

https://github.com/user-attachments/assets/828be78c-a077-42bf-b9f2-70a3b60b5fcf

https://github.com/user-attachments/assets/31fc541a-4cbe-466e-b8df-166e1bc429f6

https://github.com/user-attachments/assets/f9d37809-8fa9-4761-842a-ed780bca6950




## API Reference 🌐

The app uses OpenWeatherMap API for weather data:
- ☀️ Current Weather
- 🕒 Hourly Forecast
- 🔃 7-day Forecast
- 💨 Air Quality Data
- 📍 Geocoding

## License 🔒

MIT License - See LICENSE file for details

## Contributing 🖋️

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

