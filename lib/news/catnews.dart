import 'package:flutter/material.dart';
import 'home.dart';
import 'package:news_app/helpfolder/news.dart';
import 'package:news_app/models/articlemodel.dart';
class catnews extends StatefulWidget {
  final String cat,cou;
  catnews({this.cat,this.cou});
  //const catnews ({ Key key, this.cou ,this.cat}): super(key: key);
  @override
  _catnewsState createState() => _catnewsState();
}

class _catnewsState extends State<catnews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  List<ArticleModel> articlestemp = new List<ArticleModel>();
  bool _loading = true;
  String _selectedItem ;//widget.cou;
  @override
  void initState(){
    super.initState();
    _selectedItem = widget.cou;
    fetchnews(widget.cou);
  }
  fetchnews(String _selectedItem) async{
    CatNews ns = CatNews();
    await ns.getNews(widget.cat,_selectedItem);
    articles = ns.news;
    setState(() {
      _loading = false;
    });
  }
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
        actions: <Widget>[
          /*PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(child: Text("India"), value: "in"),
              PopupMenuItem(
                  child: Text("USA"), value: "us"),
              //PopupMenuItem(child: Text("Settings"), value: "/settings"),
            ],
            onSelected: (value) {
              setState(() {
                print(_selectedItem);
                if(_selectedItem!=value){
                _selectedItem = value;
                print(_selectedItem);
                _loading=true;
                fetchnews(_selectedItem);}
              });
            },
          ),*/
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
                  fetchnews(_selectedItem);}
              });
            },
          ),
        ],

        elevation: 0.0,
      ),
      body: _loading ? Container(child: Center(child: CircularProgressIndicator())): Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              height: MediaQuery.of(context).size.height*0.82,
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return MainTile(imgurl: articles[index].iurl, title: articles[index].title, description: articles[index].description,url: articles[index].url);
                },
              ),
            ),
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