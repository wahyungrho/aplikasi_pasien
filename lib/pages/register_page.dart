import 'dart:convert';
import 'package:aplikasi_pasien/network/api/url_api.dart';
import 'package:aplikasi_pasien/pages/login_page.dart';
import 'package:flutter/material.dart';
//import 'package:sim_user_pasien/pages/login_page.dart';
import 'package:aplikasi_pasien/widget/button_primary.dart';
import 'package:aplikasi_pasien/widget/general_logo_space.dart';
import 'package:aplikasi_pasien/theme.dart';
import 'package:http/http.dart' as http;

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPages> {
  TextEditingController no_identitasController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController teleponeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "no_identitas": no_identitasController.text,
      "nama": namaController.text,
      "alamat": alamatController.text,
      "telepone": teleponeController.text,
      "username": usernameController.text,
      "password": passwordController.text,
    });
    final data = jsonDecode(response.body);
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPages()),
                            (route) => false);
                      },
                      child: Text("Ok"))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "FORM REGISTRASI",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Register New Your Account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(
                  height: 20,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: no_identitasController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'NIK',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nama Pasien',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: alamatController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Alamat',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: teleponeController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Telepon',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                //Note::Text Field
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "DAFTAR",
                    onTap: () {
                      if (no_identitasController.text.isEmpty ||
                          namaController.text.isEmpty ||
                          alamatController.text.isEmpty ||
                          teleponeController.text.isEmpty ||
                          usernameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Warning !!!"),
                                  content: Text("Please, enter the fields"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("ok"))
                                  ],
                                ));
                      } else {
                        registerSubmit();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPages()),
                            (Route) => false);
                      },
                      child: Text(
                        "Login now",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
