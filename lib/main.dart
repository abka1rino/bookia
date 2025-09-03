import 'package:bookia/core/utils/theme.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Bookia());
}

class Bookia extends StatelessWidget {
  const Bookia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: const SplashScreen(),
    );
  }
}
