import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/state_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SearchBarWidget extends StatelessWidget {

  SearchBarWidget({Key? key}) : super(key: key);

  final TextEditingController cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<StateProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Stack(
      children: [
        Container(
          height: 50,
          width: 350,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // onTap: () => stateProvider.switchToExpanded(true),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.white,
                              showCursor: stateProvider.searchBarTapped,
                              controller: cityNameController,
                              style: const TextStyle(
                                color: Colors.white60,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                suffixIcon: IconButton(
                                  onPressed:
                                      () async {
                                    weatherProvider.userInputCity = cityNameController.text;
                                    await weatherProvider.updateCityAndFetchWeather();
                                  },
                                  icon: const Icon(Icons.search),
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
