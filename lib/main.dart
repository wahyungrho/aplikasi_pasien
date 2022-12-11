import 'package:flutter/material.dart';
import 'package:aplikasi_pasien/pages/splash_screen.dart';
import 'package:aplikasi_pasien/theme.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: SplashScreen(),
    );
  }
}
