import 'package:news_app/models/Cat_Model.dart';
List<Cateogary_Model> getCateogaries(String s){
  List<Cateogary_Model> cateogary = new List<Cateogary_Model>();
  Cateogary_Model cm = new Cateogary_Model();
  //1
  cm.name = "Business";
  cm.imgurl = "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=749&q=80";
  cm.country=s;
  cateogary.add(cm);
  cm = new Cateogary_Model();
  //2
  cm.country=s;
  cm.name = "Entertainment";
  cm.imgurl = "https://images.unsplash.com/photo-1586899028174-e7098604235b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80";
      cateogary.add(cm);
  cm = new Cateogary_Model();
  //3
  cm.country=s;
  cm.name = "Sports";
  cm.imgurl = "https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";
      cateogary.add(cm);
  cm = new Cateogary_Model();
  //4
  cm.country=s;
  cm.name = "Health";
  cm.imgurl = "https://images.unsplash.com/photo-1542736667-069246bdbc6d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80";
  cateogary.add(cm);
  cm = new Cateogary_Model();
  //5
  cm.country=s;
  cm.name = "Science";
  cm.imgurl = "https://images.unsplash.com/photo-1574170609519-d1d8d4b71f60?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80";
  cateogary.add(cm);
  cm = new Cateogary_Model();
  //6
  cm.country=s;
  cm.name = "Technology";
  cm.imgurl = "https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80";
  cateogary.add(cm);
  return cateogary;
}