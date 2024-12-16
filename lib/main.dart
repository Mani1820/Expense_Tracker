import 'package:expence_tracker/expenses_list/expence.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final kColourScheme = ColorScheme.fromSeed(
    seedColor: Colors.orange,
  );
  final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 5, 99, 125),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.onPrimary,
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onPrimary,
            foregroundColor: kDarkColorScheme.primary,
            elevation: 20,
            shadowColor: Colors.black45),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.onSecondaryContainer,
              foregroundColor: kDarkColorScheme.secondaryContainer),
        ),
        textTheme: TextTheme().copyWith(
          displayMedium: TextStyle(color: kDarkColorScheme.inversePrimary),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColourScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColourScheme.primary,
            foregroundColor: kColourScheme.primaryContainer,
            elevation: 20,
            shadowColor: Colors.black45),
        cardTheme: CardTheme().copyWith(
          color: kColourScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColourScheme.onSecondaryContainer,
              foregroundColor: kColourScheme.secondaryContainer),
        ),
        textTheme: TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColourScheme.secondary,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Expence(),
    );
  }
}
