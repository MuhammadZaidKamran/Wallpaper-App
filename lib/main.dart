import 'package:flutter/material.dart';
import 'package:wallpaper_app_2/Views/HomeView/home_view.dart';
import 'package:wallpaper_app_2/Views/SearchView/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchView(),
    );
  }
}