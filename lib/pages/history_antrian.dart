import 'dart:convert';

import 'package:aplikasi_pasien/network/api/url_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryAntrian extends StatefulWidget {
  const HistoryAntrian({Key key}) : super(key: key);

  @override
  State<HistoryAntrian> createState() => _HistoryAntrianState();
}

class _HistoryAntrianState extends State<HistoryAntrian> {
  bool isLoading = false;
  List list = [];
  String totalAntrian = '0';

  Future<void> getListAntrian() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userID = preferences.getInt('userID');
    if (kDebugMode) {
      print(userID);
    }
    var response = await http.post(Uri.parse(BASEURL.listAntrian),
        body: {"userID": userID.toString()});
    final data = jsonDecode(response.body);
    totalAntrian = await BASEURL.totalAntrian();
    setState(() {
      isLoading = false;
      list = data;
    });
    if (kDebugMode) {
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    getListAntrian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff053F5E),
        title: const Text("Riwayat Antrian"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Total Antrian Hari Ini : $totalAntrian",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView(
                      children: list
                          .map((e) => Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      _showMyDialog(e);
                                    },
                                    title: Text(
                                        "Nomer Antrian ${e['no_antrian']}"),
                                    subtitle: Text(
                                        "Tanggal Kunjungan ${e['tanggal_kunjungan']}"),
                                  ),
                                  const Divider(
                                    height: 0,
                                    color: Colors.grey,
                                  ),
                                ],
                              ))
                          .toList()),
                ),
              ],
            ),
    );
  }

  Future<void> _showMyDialog(item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No. Antrian : ${item['no_antrian']}"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Nama Pasien : ${item['nama'].toString().toUpperCase()}"),
                const SizedBox(height: 5),
                Text("Tanggal Kunjungan : ${item['tanggal_kunjungan']}"),
                const SizedBox(height: 5),
                Text("No Telp : ${item['telepone']}"),
                const SizedBox(height: 5),
                Text("Alamat : ${item['alamat']}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
