import 'package:flutter/material.dart';

class SearchCitiesScreen extends StatelessWidget {
  static String routeName = "/SearchCitiesScreen";
  const SearchCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
              child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: "City",
                onSubmitted: (String query) {
                  // Perform search with the query
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
