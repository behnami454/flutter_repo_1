import 'package:flutter/material.dart';
import 'package:my_news_app/screens/splash_screens.dart';
import 'package:my_news_app/services/service_locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мои новости',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blueGrey,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
