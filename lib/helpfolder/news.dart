import 'dart:convert';
import 'package:news_app/models/articlemodel.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news/home.dart';
class News {
  List<ArticleModel> news = [];
Future<void> getNews(String url) async{
  //String url = "https://newsapi.org/v2/top-headlines?country=$s&pageSize=100&apiKey=8b12b29c30f546fc8213b53626434d8c";//"https://jobs.github.com/positions.json?location=remote"
  var response = await http.get(url);
  var jdata = jsonDecode(response.body);
  if(jdata['status']== "ok"){
    if(jdata["articles"].length>0){
    jdata["articles"].forEach((element){
      if(element["urlToImage"] != null && element["description"]!=null)
        {
          ArticleModel articlemodel = ArticleModel(
            auth: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            iurl: element["urlToImage"],
            content: element["content"],
          );
          //print(articlemodel.pub);
          //print(element["publishedAt"]);
          news.add(articlemodel);
        }

    });
  }}
 }
}
class CatNews {
  List<ArticleModel> news = [];
  Future<void> getNews(String cat,String co) async{
    String url = "https://newsapi.org/v2/top-headlines?country=$co&category=$cat&pageSize=100&apiKey=462a0bd872244915af38547f5a03be80";
    var response = await http.get(url);
    var jdata = jsonDecode(response.body);
    if(jdata['status']== "ok"){
      if(jdata["articles"].length>0){
      jdata["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"]!=null)
        {
          ArticleModel articlemodel = ArticleModel(
            auth: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            iurl: element["urlToImage"],
            content: element["content"],
          );
          news.add(articlemodel);
        }
      });
    }
    }
  }
}
