import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpfolder/data.dart';
import 'package:news_app/models/Cat_Model.dart';
import 'package:news_app/models/articlemodel.dart';
import 'package:news_app/helpfolder/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/news/articleview.dart';
import 'package:news_app/news/catnews.dart';
import 'package:news_app/drawerContents/globalStats.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:news_app/drawerContents/indiaStats.dart';
import 'package:news_app/drawerContents/globalnews.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static const addu = "ca-app-pub-3940256099942544~3347511713";
  //final _native = NativeAdmob();
  int _counter=1;
  List<Cateogary_Model> cateogaries = new List<Cateogary_Model>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  String _selectedItem = 'in';
  bool flag = true;
  @override
  void initState(){
    super.initState();
    cateogaries=getCateogaries(_selectedItem);
    if(_loading==true)
    fetchnews(_selectedItem);
   /* _native.initialize(
      appID: aduu;
    );*/
  }
  fetchnews(String s) async{
    News ns = News();
    await ns.getNews("https://newsapi.org/v2/top-headlines?country=$s&pageSize=100&apiKey=462a0bd872244915af38547f5a03be80");
    articles = ns.news;
    setState(() {
      _loading = false;
    });
  }/*
  fetchNews(String s,int f) async{
    print(1);
    News ns = News();
    await ns.getNews("https://newsapi.org/v2/top-headlines?country=$s&page=$f&apiKey=ea70e5874def4784bc61dd7ddef8ac67");
    List<ArticleModel> articlestemp = new List<ArticleModel>();
    articlestemp = ns.news;
    print(articlestemp.length);
    if(articlestemp.length>-1){
    for(int i =0;i<articlestemp.length;i++)
      {
        articles.add(articlestemp[i]);
      }}
    else {
      setState(() {
        flag = false;
      });
      return;
    }
    setState(() {
      _loading = false;
    });
  }
  void increment()
  {
    setState(() {
      _counter++;
    });
  }
  void reset()
  {
    setState(() {
      _counter=1;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Tap"),
            Text("News",style: TextStyle(
              color: Colors.amber[900],
            ),)
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.location_on),
            elevation: 3.2,
            tooltip: 'Choose for changing country',
            itemBuilder: (BuildContext context){
              return choices.map((MyPopUpItem choice){
                return PopupMenuItem<MyPopUpItem>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
            onSelected: (value) {
              setState(() {
                if(_selectedItem!=value.value){
                _selectedItem = value.value;
                print(_selectedItem);
                _loading=true;
                cateogaries=getCateogaries(_selectedItem);
                fetchnews(_selectedItem);}
              });
            },
          ),
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              //child: CachedNetworkImage(imageUrl: "https://images.unsplash.com/photo-1579532536935-619928decd08?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",width: MediaQuery.of(context).size.width),//Text('Drawer Header'),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:  NetworkImage("https://images.unsplash.com/photo-1579532536935-619928decd08?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"))),
                child: Stack(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.12, MediaQuery.of(context).size.height*0.19, MediaQuery.of(context).size.width*0.1, MediaQuery.of(context).size.height*0.0125),
                    child: Text("Welcome to TapNews",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ])
              /*decoration: BoxDecoration(
                color: Colors.white,
              ),*/
            ),
            //SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            ListTile(
              title: Text('What is Happending Around the Globe'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context,MaterialPageRoute(builder: (context)=> GlobalNews(str: "-apple")));
              },
            ),
            ExpansionTile(
              title: Text("Corona Related Data"),
              children: <Widget>[ListTile(
                title: Text('Headlines Related to Corona'),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GlobalNews(str: "+corona")));
                  //Navigator.pushReplacementNamed(context, '/load');
                },
              ),
                ListTile(
               title: Text('Global Statistics'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> WorldData()));
                //Navigator.pushReplacementNamed(context, '/load');
              },
              ), ListTile(
                title: Text('Indian Statistics'),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> IData()));
                },
              ),],
            ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),

      body: _loading ? Container(
        child: Center(child: CircularProgressIndicator(
          backgroundColor: Colors.amber,
          //valueColor: Colors.amber,
        )),
      ): Container(
        child: Column(
          children: <Widget>[
            //Displaying Cateogaries at the top
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              height: MediaQuery.of(context).size.height*0.18,
              child: ListView.builder(
                  itemCount: cateogaries.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Cateogary_Tile(
                      imgurl: cateogaries[index].imgurl,
                      name: cateogaries[index].name,
                      country: cateogaries[index].country,
                    );
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){ setState(() {
                      _loading=true;
                      //cateogaries=getCateogaries(_selectedItem);
                      fetchnews(_selectedItem);
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
              ),
            ),
            //Displaying the News
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              height: MediaQuery.of(context).size.height*0.65,
              child: ListView.builder(
                itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  //print(articles.length);
                  /*if(flag==true)
                  if(articles.length-index==5)
                    {
                      //print(_counter);
                      if(_counter==1){
                       // print(1);
                        _counter++;
                        print(_counter);
                        fetchNews(_selectedItem, _counter);
                      }
                    }*/
                  return /*_loading ? Container(
                    child: Container(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.025),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                          color: Colors.white,
                        ),
                        child: Center(child: CircularProgressIndicator())),):*/
                    MainTile(imgurl: articles[index].iurl, title: articles[index].title, description: articles[index].description,url: articles[index].url);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cateogary_Tile extends StatelessWidget {
  final String imgurl,name,country;
  Cateogary_Tile({this.imgurl,this.name,this.country});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> catnews(cat: name.toLowerCase(), cou: country))
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                child: CachedNetworkImage(imageUrl: imgurl,width: MediaQuery.of(context).size.width*0.4,height: MediaQuery.of(context).size.height*0.14,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.4,height: MediaQuery.of(context).size.height*0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                color: Colors.black26,
              ),
              child: Text(name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MainTile extends StatelessWidget {
  final String imgurl, title, description,url;
  MainTile({@required this.imgurl,@required this.title,@required this.description,@required this.url});
  @override
  Widget build(BuildContext context) {
    //print('$pub');
    //DateTime d = DateTime.parse(pub);
    //print('$d');
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> artnews(
          url: url,
        )));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
          color: Colors.white,
            /*boxShadow: [new BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),]*/
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                child: Image.network(imgurl)
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.0015),
            Text(description,
            style:TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54,
            ),),
          ],
        ),
      ),
    );
  }
}
class MyPopUpItem
{
  MyPopUpItem({this.title,this.value});
  String title;
  String value;
}

List<MyPopUpItem> choices=<MyPopUpItem>[
  MyPopUpItem(title:'Argentina', value:'ar'),
  MyPopUpItem(title:'Austria', value:'at'),
  MyPopUpItem(title:'Australia', value:'au'),
  MyPopUpItem(title:'Brazil', value:'br'),
  MyPopUpItem(title:'Belgium', value:'be'),
  MyPopUpItem(title:'Bulgaria', value:'bg'),
  MyPopUpItem(title:'Canada', value:'ca'),
  MyPopUpItem(title:'Egypt', value:'eg'),
  MyPopUpItem(title:'France', value:'fr'),
  MyPopUpItem(title:'Germany', value:'de'),
  MyPopUpItem(title:'HonkKong', value:'hk'),
  MyPopUpItem(title:'Hungary', value:'hu'),
  MyPopUpItem(title:'India', value:'in'),
  MyPopUpItem(title:'Indonesia', value:'id'),
  MyPopUpItem(title:'Israel', value:'il'),
  MyPopUpItem(title:'Italy', value:'it'),
  MyPopUpItem(title:'Japan', value:'jp'),
  MyPopUpItem(title:'Malaysia', value:'my'),
  MyPopUpItem(title:'Mexico', value:'mx'),
  MyPopUpItem(title:'Morocco', value:'ma'),
  MyPopUpItem(title:'New Zealand', value:'nz'),
  MyPopUpItem(title:'Nigeria', value:'ng'),
  MyPopUpItem(title:'Netherlands', value:'nl'),
  MyPopUpItem(title:'Norway', value:'no'),
  MyPopUpItem(title:'Phillippines', value:'ph'),
  MyPopUpItem(title:'Poland', value:'pl'),
  MyPopUpItem(title:'Portugal', value:'pt'),
  MyPopUpItem(title:'Russia', value:'ru'),
  MyPopUpItem(title:'Singapore', value:'sg'),
  MyPopUpItem(title:'South Africa', value:'za'),
  MyPopUpItem(title:'South Korea', value:'kr'),
  MyPopUpItem(title:'Switzerland', value:'ch'),
  MyPopUpItem(title:'Turkey', value:'tr'),
  MyPopUpItem(title:'Thailand', value:'th'),
  MyPopUpItem(title:'Ukraine', value:'ua'),
  MyPopUpItem(title:'UAE', value:'ae'),
  MyPopUpItem(title:'UK', value:'gb'),
  MyPopUpItem(title:'USA', value:'us'),
];
