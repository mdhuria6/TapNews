import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news/home.dart';
class GlobalNews extends StatefulWidget {
  final String str;
  GlobalNews({this.str});
  @override
  _GlobalNewsState createState() => _GlobalNewsState();
}

class _GlobalNewsState extends State<GlobalNews> {
  List<ArticleModel> Gnews = new List<ArticleModel>();
  bool _loading = true;
  String _value = 'publishedAt';
  String k;
  @override
  void initState() {
    super.initState();
    k=widget.str;
    if (_loading == true)
      CollectNews(_value,widget.str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Tap"),
            Text("News", style: TextStyle(
              color: Colors.amber[900],
            ),)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: (){ setState(() {
                _loading=true;
                //cateogaries=getCateogaries(_selectedItem);
                CollectNews(_value, k);
              });
              },
              child: Container(
                //width: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.refresh,
                  color: Colors.amber[900],
                  size: 28.0,
                  semanticLabel: 'Refresh',
                ),
              ),
            ),
          ),],
        elevation: 0.0,
      ),
      body: _loading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Container(
        child: Column(
          children: <Widget>[
            //sort the News
            k!="+corona"?Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('SortBy: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                SizedBox(width: 10),
                DropdownButton(
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("Popularity"),
                        value: 'popularity',
                      ),
                      DropdownMenuItem(
                          child: Text("Newest First"),
                          value: 'publishedAt'
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        _loading=true;
                        Gnews=[];
                        CollectNews(_value,widget.str);
                      });
                    }),
              ],
            ):SizedBox(),
            //Displaying the News
        Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              height: (k!="+corona")?MediaQuery.of(context).size.height*0.78:MediaQuery.of(context).size.height*0.87,
              child: ListView.builder(
                itemCount: Gnews.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return MainTile(imgurl: Gnews[index].iurl,
                      title: Gnews[index].title,
                      description: Gnews[index].description,
                      url: Gnews[index].url);
                },
              ),
            ),
          ],
        ),
      ],),
    ));
  }

  CollectNews(String sort,String s) async {
    print(sort);
    print(s);
    String url;
    if(s=="+corona")
      url = "https://newsapi.org/v2/everything?q=$s&q=+covid-19&qInTitle=+corona&qInTitle=+covid-19&pageSize=100&language=en&apiKey=462a0bd872244915af38547f5a03be80";
    else
      url = "https://newsapi.org/v2/everything?q=$s&sortBy=$sort&pageSize=100&language=en&apiKey=462a0bd872244915af38547f5a03be80";
    var response = await http.get(url);
    var jdata = jsonDecode(response.body);
    print(jdata);
    if (jdata['status'] == "ok") {
      jdata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articlemodel = ArticleModel(
            auth: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            iurl: element["urlToImage"],
            content: element["content"],
          );
          Gnews.add(articlemodel);
        }
      });
    }
    setState(() {
      _loading=false;
    });
  }
}