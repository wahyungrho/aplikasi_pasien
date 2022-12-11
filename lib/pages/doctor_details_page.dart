import 'dart:convert';

import 'package:aplikasi_pasien/network/api/url_api.dart';
import 'package:aplikasi_pasien/pages/history_antrian.dart';
import 'package:aplikasi_pasien/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pasien/utils/colors_util.dart';
import 'package:aplikasi_pasien/utils/date_utils.dart' as date_util;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AntrianPages extends StatefulWidget {
  const AntrianPages({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AntrianPagesState createState() => _AntrianPagesState();
}

class _AntrianPagesState extends State<AntrianPages> {
  double width = 0;
  double height = 0;
  bool isLoading = false, isLoadingPage = false;
  int selectedDay = 0;

  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  String totalAntrian = '0';
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');
  final dates = <Widget>[];

  getAntrian() async {
    setState(() {
      isLoadingPage = true;
    });
    totalAntrian = await BASEURL.totalAntrian();
    setState(() {
      isLoadingPage = false;
    });
  }

  @override
  void initState() {
    super.initState();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();

    getAntrian();
  }

  Widget backgroundView() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#072965"),
        image: DecorationImage(
          image: const AssetImage("assets/bg.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.lighten),
        ),
      ),
    );
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      width: width,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
              // print(DateFormat('yyyy-MM-dd').format(currentDateTime));
            });
          },
          child: Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (currentMonthList[index].day != currentDateTime.day)
                        ? [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.6)
                          ]
                        : [
                            HexColor("ED6184"),
                            HexColor("EF315B"),
                            HexColor("E2042D")
                          ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget topView() {
    return Container(
        height: height * 0.35,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                HexColor("488BC8").withOpacity(0.7),
                HexColor("488BC8").withOpacity(0.5),
                HexColor("488BC8").withOpacity(0.3)
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(4, 4),
                spreadRadius: 2)
          ],
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                "Total Antrian Hari Ini : $totalAntrian",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Pilih Tanggal Berkunjung :",
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: titleView(),
            // ),
            // hrizontalCapsuleListView(),
            SizedBox(
              height: 80,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                children: dates.map((widget) => widget).toList(),
              ),
            ),
          ],
        ));
  }

  Widget btnAction() {
    return Align(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
            onPressed: () {
              submitAntrian();
            },
            child: (isLoading)
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Ambil Antrian")),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    dates.clear();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    for (int i = 0; i < 7; i++) {
      final date = _currentDate.add(Duration(days: i));
      dates.add(InkWell(
        onTap: () {
          setState(() {
            selectedDay = i;
            currentDateTime = date;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color:
                    (selectedDay == i) ? const Color(0xff053F5E) : Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _dayFormatter.format(date),
                  style: TextStyle(
                      color: (selectedDay == i)
                          ? Colors.white
                          : const Color(0xff053F5E)),
                ),
                Text(
                  _monthFormatter.format(date),
                  style: TextStyle(
                      color: (selectedDay == i)
                          ? Colors.white
                          : const Color(0xff053F5E)),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return Scaffold(
      body: (isLoadingPage)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[backgroundView(), topView(), btnAction()],
            ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff053F5E),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePages()),
                (Route) => false);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HistoryAntrian()));
              },
              icon: const Icon(Icons.history))
        ],
      ),
    );
  }

  submitAntrian() async {
    setState(() {
      isLoading = true;
    });
    var urlAntrian = Uri.parse(BASEURL.getAntrian);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userID = preferences.getInt('userID');
    final response = await http.post(urlAntrian, body: {
      "userID": userID.toString(),
      // "tgl_antrian": startDateController.text
      "tgl_antrian": DateFormat('yyyy-MM-dd').format(currentDateTime)
    });
    final data = jsonDecode(response.body);
    setState(() {
      isLoading = false;
    });
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HistoryAntrian()));
                      },
                      child: Text("Lihat Antrian Saya"))
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              ));
    }
    setState(() {});
  }
}
