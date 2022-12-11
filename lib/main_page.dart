import 'package:aplikasi_pasien/pages/home_page.dart';
import 'package:aplikasi_pasien/pages/profil_page.dart';
import 'package:aplikasi_pasien/theme.dart';
import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectIndex = 0;

  final _pageList = [
    HomePages(),
    ProfilPages(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: "Profile"),
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
      ),
    );
  }
}
