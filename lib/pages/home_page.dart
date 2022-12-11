import 'package:aplikasi_pasien/pages/doctor_details_page.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pasien/widget/button_primary.dart';
import 'package:aplikasi_pasien/widget/general_logo_space.dart';
import 'package:aplikasi_pasien/widget/widget_ilustration.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
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
            image: "assets/antrian1.png",
            title: "Selamat Datang di SIM Praktik Dokter Umum dr. Tri Indriani",
            subtitle1: "Silahkan Pilih Jadwal Pengobatanmu",
            child: ButtonPrimary(
                text: "Ambil Antrian",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AntrianPages()));
                }),
          ),
        ],
      )),
    );
  }
}
