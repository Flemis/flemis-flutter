import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  String get searchFieldLabel => 'Search';
  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 15,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        elevation: 0,
      ),
      textTheme: const TextTheme(
          headline6: TextStyle(
              color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold)),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: whiteColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: whiteColor),
        hoverColor: whiteColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
      ),
      hintColor: whiteColor,
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
  
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty ? [] : [];
    return Container(
      color: primaryColor,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (content, index) => ListTile(
            leading: const Icon(Icons.arrow_left), title: Text(suggestions[index])),
      ),
    );
  }
}
