import 'package:aplikasi_pasien/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pasien/pages/register_page.dart';
import 'package:aplikasi_pasien/widget/button_primary.dart';
import 'package:aplikasi_pasien/widget/general_logo_space.dart';
import 'package:aplikasi_pasien/widget/widget_ilustration.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          WidgetIlustration(
            image: "assets/splash_ilustration.png",
            title: "Selamat Datang di SIM Praktik Dokter Umum dr. Tri Indriani",
            subtitle1:
                "Ayo temukan masalah kesehatanmu, dengan berkonsultasi bersama dr. Tri Indriani",
            child: ButtonPrimary(
              text: "GET STARTED",
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPages()));
              },
            ),
          ),
        ],
      )),
    );
  }
}
