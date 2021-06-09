import 'package:http/http.dart';
import 'dart:convert';
//import 'package:intl/intl.dart';
class TCases{
  var cases;
  var deceased;
  var recovered;
  var active;
  var tcases;
  var trecovered;
  var tdeceased;
  TCases();
  Future<void> getdata() async{
    Response response = await get('https://corona.lmao.ninja/v2/all');
    Map data = jsonDecode(response.body);
    cases= data['cases'];
    recovered= data['recovered'];
    deceased=data['deaths'];
    active= data['active'];
    tcases= data['todayCases'];
    trecovered= data['todayRecovered'];
    tdeceased= data['todayDeaths'];
  }
}
