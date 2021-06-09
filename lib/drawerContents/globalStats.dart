import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:news_app/drawerContents/totalcase.dart';
class WorldData extends StatefulWidget {
  @override
  _WorldDataState createState() => _WorldDataState();
}

class _WorldDataState extends State<WorldData> {
  Map data = {};
  bool _loading = true;
  bool _flag = false;
  setupdata() async{
    TCases ex= TCases();
    await ex.getdata();
    data['rec'] = ex.recovered;
    data['act']=ex.active;
    data['total']=ex.cases;
    data['dec']=ex.deceased;
    data['ttotal']=ex.tcases;
    data['tdec']=ex.tdeceased;
    data['trec']=ex.trecovered;
   // _loading = false;
    if(_flag==false){
    generatedata();
    _generatedata();}
    setState(() {
      _loading=false;
      _flag = true;
    });
  }
  List<charts.Series<Task,String>> _seriespiedata = new List<charts.Series<Task,String>>();
  generatedata(){
    var piedata=[
      //data['act']=double.parse(data['act']),
      //data['rec']=double.parse(data['rec']),
      //data['dec']=double.parse(data['dec']),
      // new Task('Total Cases',data['cases'],Colors.blue[600]),
      new Task('Active Cases',data['act'],Colors.deepOrange[900],((data['act']/data['total'])*100)),
      new Task('Recovered',data['rec'],Colors.lightGreen[800],((data['act']/data['total'])*100)),
      new Task('Deceased',data['dec'],Colors.grey[600],((data['act']/data['total'])*100)),
    ];
    _seriespiedata.add(
      charts.Series(
        data: piedata,
        domainFn: (Task task,_)=> task.task,
        measureFn: (Task task,_)=> task.taskvalue,
        colorFn: (Task task,_)=> charts.ColorUtil.fromDartColor(task.c),
        id:'WorldStatistics',
        //labelAccessorFn: (Task row,_)=>'${row.perc}',
      ),
    );
  }
  List<charts.Series<Task,String>> seriespiedata = new List<charts.Series<Task,String>>();
  _generatedata(){
    var piedata=[
      //data['act']=double.parse(data['act']),
      //data['rec']=double.parse(data['rec']),
      //data['dec']=double.parse(data['dec']),
      // new Task('Total Cases',data['cases'],Colors.blue[600]),
      new Task('Active Cases',data['ttotal'],Colors.deepOrange[900],((data['act']/data['total'])*100)),
      new Task('Recovered',data['trec'],Colors.lightGreen[800],((data['act']/data['total'])*100)),
      new Task('Deceased',data['tdec'],Colors.grey[600],((data['act']/data['total'])*100)),
    ];
    seriespiedata.add(
      charts.Series(
        data: piedata,
        domainFn: (Task task,_)=> task.task,
        measureFn: (Task task,_)=> task.taskvalue,
        colorFn: (Task task,_)=> charts.ColorUtil.fromDartColor(task.c),
        id:'WorldStatistics',
        //labelAccessorFn: (Task row,_)=>'${row.perc}',
      ),
    );
  }
  //_seriespiedata=List<charts.Series<Task,String>>();
  //generatedata();
  //seriespiedata=List<charts.Series<Task,String>>();
 // _generatedata();
  //print(data);

  @override
  void initState() {
    super.initState();
    //generatedata();
    //generatedata();
    //seriespiedata=List<charts.Series<Task,String>>();
   // _generatedata();
    if(_loading==true)
    setupdata();
    //seriespiedata=List<charts.Series<Task,String>>();
  }


  @override
  Widget build(BuildContext context) {
    /*_seriespiedata=List<charts.Series<Task,String>>();
    generatedata();
    seriespiedata=List<charts.Series<Task,String>>();
    _generatedata();*/
    print(data);
    return Scaffold(
      backgroundColor: Colors.white,
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
    actions: [Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: (){ setState(() {
          _loading=true;
          //cateogaries=getCateogaries(_selectedItem);
          setupdata();
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
      body:_loading ? Container(
        child: Center(child: CircularProgressIndicator(
          backgroundColor: Colors.amber,
          //valueColor: Colors.amber,
        )),
      ):Container(
        child: Column(
          //scrollDirection: Axis.vertical,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04,MediaQuery.of(context).size.height*0.04,0,MediaQuery.of(context).size.height*0),
              child: Text('STATISTICS',style:TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
              ),),
            ),
            Padding(
              padding:EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.height*0.04,MediaQuery.of(context).size.width*0.05,0),
              child: OrientationBuilder(
                  builder: (context,orientation) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all( Radius.circular(20)),
                        /*gradient: LinearGradient(
                          colors: [Colors.lightBlue[50],Colors.white],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        ),*/
                        boxShadow: [BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1,1),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),],
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.35,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              putdata(Colors.amber[900],'Total Cases',data['total']),
                              putdata(Colors.deepOrange[900],'Active Cases',data['act']),
                              putdata(Colors.lightGreen[800],'Recovered',data['rec']),
                              putdata(Colors.grey[600],'Deceased',data['dec']),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width*0.02),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: MediaQuery.of(context).size.width * 0.53,
                              child: charts.PieChart(
                                _seriespiedata,
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                defaultRenderer: new charts
                                    .ArcRendererConfig(
                                  arcWidth: 25,
                                  /*arcRendererDecorators: [
                                          new charts.ArcLabelDecorator(
                                            labelPosition: charts.ArcLabelPosition.inside,
                                          )
                                        ],*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );}
              ),
            ),
            Padding(
              padding:EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.height*0.03,MediaQuery.of(context).size.width*0.05,0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all( Radius.circular(20)),
                  /*gradient: LinearGradient(
                    colors: [Colors.lightBlue[50],Colors.white],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                  ),*/
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    offset: Offset(1,1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),],
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10,top: 6),
                          child: Text('Today\'s Data',style: TextStyle( fontSize:16,fontWeight: FontWeight.bold ,color: Colors.amber[900]),),
                        ),
                        putdata(Colors.deepOrange[900],'Active Cases',data['ttotal']),
                        putdata(Colors.lightGreen[800],'Recovered',data['trec']),
                        putdata(Colors.grey[600],'Deceased',data['tdec']),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child:charts.PieChart(
                          seriespiedata,
                          animate: true,
                          animationDuration: Duration(seconds: 5),
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 20,
                            /*arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                        labelPosition: charts.ArcLabelPosition.inside,
                                      )
                                    ],*/
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pushReplacementNamed(context,'/home');
        },
      ),*/
    );
  }

  Widget putdata(Color d,String head,var cases) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,20,0,0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.label,
            color: d,
            size: 16,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$head',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: d,),textAlign: TextAlign.left,),
              Text('$cases',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: d),textAlign: TextAlign.left,),
            ],
          ),
        ],
      ),
    );
  }

  /*Widget stat() {
    return Column(
      //scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(top: 25.0),
          child: Stack(
            children: [
              Image.asset('images/virus2.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(25,70,25,0),
                child: Text('STATISTICS',style:TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      ],
    );
  }*/
}

class Task{
  String task;
  var taskvalue;
  Color c;
  var perc;
  Task(this.task,this.taskvalue,this.c,this.perc);
}