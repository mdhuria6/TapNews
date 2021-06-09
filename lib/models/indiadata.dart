import 'dart:convert';
import 'package:http/http.dart' as http;
class IndianData{
  String active;
  String confirmed;
  String deaths;
  String recovered;
  String state;
  String statecode;
  IndianData({this.active,this.confirmed,this.deaths,this.recovered,this.state,this.statecode});
}

class Indd{
  List<IndianData> d = [];
  Future<void> getData() async{
    String url = "https://api.covid19india.org/data.json";
    var response = await http.get(url);
    var jdata = jsonDecode(response.body);
    if(jdata["statewise"].length>0)
      {
        jdata["statewise"].forEach((element){
          if(element["statecode"]!="UN" && element["statecode"]!="TT" ){
          IndianData indi = IndianData(
            active : element["active"],
            confirmed: element["confirmed"],
            deaths: element["deaths"],
            recovered: element["recovered"],
            state: element["state"],
            statecode: element["statecode"],
          );
          d.add(indi);}
        });
      }
  }
}
class Ind{
  List<IndianData> d = [];
  Future<void> getData() async{
    String url = "https://api.covid19india.org/data.json";
    var response = await http.get(url);
    var jdata = jsonDecode(response.body);
    if(jdata["statewise"].length>0)
    {
      jdata["statewise"].forEach((element){
        if(element["statecode"]=="TT" ){
          IndianData indi = IndianData(
            active : element["active"],
            confirmed: element["confirmed"],
            deaths: element["deaths"],
            recovered: element["recovered"],
            state: element["state"],
            statecode: element["statecode"],
          );
          d.add(indi);}
      });
    }
  }
}