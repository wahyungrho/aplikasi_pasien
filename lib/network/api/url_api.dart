import 'dart:convert';

import 'package:http/http.dart' as http;

class BASEURL {
  static String ipAddress = "192.168.242.30";
  static String apiRegister =
      "http://$ipAddress/aplikasi_pasien_db/register_api.php";
  static String apiLogin = "http://$ipAddress/aplikasi_pasien_db/login_api.php";
  static String getAntrian =
      "http://$ipAddress/aplikasi_pasien_db/proccess_antrian.php";
  static String listAntrian =
      "http://$ipAddress/aplikasi_pasien_db/history_antrian.php";
  static String totalAntrianAPI =
      "http://$ipAddress/aplikasi_pasien_db/total_antrian.php";

  static Future<String> totalAntrian() async {
    var response = await http.get(Uri.parse(totalAntrianAPI));
    var data = jsonDecode(response.body);
    return data['result'].toString();
  }
}
