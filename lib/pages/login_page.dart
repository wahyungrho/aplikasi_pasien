import 'dart:convert';

import 'package:aplikasi_pasien/network/api/url_api.dart';
import 'package:aplikasi_pasien/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pasien/theme.dart';
import 'package:aplikasi_pasien/widget/button_primary.dart';
import 'package:aplikasi_pasien/widget/general_logo_space.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_pasien/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "username": usernameController.text,
      "password": passwordController.text
    });
    final data = jsonDecode(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int value = data['value'];
    String message = data['message'];
    preferences.setInt('userID', data['userID']);
    print(data['userID']);
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
                                builder: (context) => MainPages()),
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
            height: 100,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "LOGIN",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Silahkan Melakukan Login Terlebih Dahulu !",
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
                    text: "LOGIN",
                    onTap: () {
                      if (usernameController.text.isEmpty ||
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
                        submitLogin();
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
                      "Don't have an account?",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPages()),
                            (Route) => false);
                      },
                      child: Text(
                        "Create Account",
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
