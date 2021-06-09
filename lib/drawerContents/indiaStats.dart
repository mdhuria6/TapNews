import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/indiadata.dart';
import "package:collection/collection.dart";
class IData extends StatefulWidget {
  @override
  _IDataState createState() => _IDataState();
}

class _IDataState extends State<IData> {
  List<IndianData> data = new List<IndianData>();
  List<IndianData> Data = new List<IndianData>();
  bool _loading  = true;
  bool _flag = false;
  String _value='State';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }
  fetchdata() async{
    Indd a = Indd();
    Ind b = Ind();
    await a.getData();
    data = a.d;
    await b.getData();
    Data = b.d;
    if(_flag==false)
    await sort(_value);
    //await arrange(data);
    setState(() {
      _loading = false;
      _flag = true;
    });
  }
  /*void arrange(List<IndianData> data)
  {
    int x=0;
    IndianData a;
    for(int i=0;i<data.length;i++)
    {
      if(data[i].state=='Total')
      {
        a=data[i];
        x=i;
      }
    }
    for(int i=x;i>0;i--)
    {
      data[x]=data[x-1];
    }
    data[0]=a;
  }*/
  void sort(String val){
    if(val=='State')
    {
      data.sort((a, b) {
        return compareAsciiUpperCase(a.state, b.state);});
    }
    else if(val=='Active')
    {
      data.sort((a,b)=> (int.parse(a.active)).compareTo(int.parse(b.active)));
    }
    else if(val=='Recovered')
    {
      data.sort((a,b)=> (int.parse(a.recovered)).compareTo(int.parse(b.recovered)));
    }
    else if(val=='Deceased')
    {
      data.sort((a,b)=> (int.parse(a.deaths)).compareTo(int.parse(b.deaths)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
              _flag=false;
              //cateogaries=getCateogaries(_selectedItem);
              fetchdata();
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
        child: Center(child: CircularProgressIndicator(
          backgroundColor: Colors.amber,
          //valueColor: Colors.amber,
        )),
      ):Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
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
                        child: Text("State"),
                        value: 'State',
                      ),
                      DropdownMenuItem(
                          child: Text("Active Cases"),
                          value: 'Active'
                      ),
                      DropdownMenuItem(
                          child: Text("Deceased"),
                          value: 'Deceased'
                      ),
                      DropdownMenuItem(
                          child: Text("Recovered"),
                          value: 'Recovered'
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        //_loading=true;
                       // data=null;
                        //fetchdata();
                        sort(_value);
                      });
                    }),
              ],
            ),
          Container(padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              child: Maintile(active: Data[0].active, confirmed: Data[0].confirmed, deaths: Data[0].deaths,recovered: Data[0].recovered, state: Data[0].state,statecode: Data[0].statecode)),
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, MediaQuery.of(context).size.height*0.01, MediaQuery.of(context).size.width*0.04, 0),
              height: MediaQuery.of(context).size.height*0.65,
              child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return MainTile(active: data[index].active, confirmed: data[index].confirmed, deaths: data[index].deaths,recovered: data[index].recovered, state: data[index].state,statecode: data[index].statecode);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MainTile extends StatelessWidget {
  int index;
  final String active,confirmed,deaths,recovered,state,statecode;
  MainTile({this.active,this.confirmed,this.deaths,this.recovered,this.state,this.statecode, int index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03,horizontal: MediaQuery.of(context).size.width*0.03),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all( Radius.circular(20)),
          /*boxShadow: [BoxShadow(
            color: Colors.black12,
            offset: Offset(1,1),
            spreadRadius: 1,
            blurRadius: 3,
          ),],*/
        ),
        width: MediaQuery.of(context).size.width ,//* 0.35,
        height: MediaQuery.of(context).size.height * 0.27,
        //margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*ClipRRect(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                child: Image.network(imgurl)
            ),*/
            Text("$state",textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
                fontSize: 18,

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text("Confirmed: $confirmed",textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
                fontSize: 14,

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text("Active : $active",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange[900],
                fontSize: 14,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text("Deceased: $deaths",
              style:TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text("Recovered: $recovered",textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.lightGreen[800],
                fontWeight: FontWeight.bold,
                fontSize: 14,

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Maintile extends StatelessWidget {
  int index;
  final String active,confirmed,deaths,recovered,state,statecode;
  Maintile({this.active,this.confirmed,this.deaths,this.recovered,this.state,this.statecode, int index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01,horizontal: MediaQuery.of(context).size.width*0.03),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all( Radius.circular(20)),
          /*boxShadow: [BoxShadow(
            color: Colors.black12,
            offset: Offset(1,1),
            spreadRadius: 1,
            blurRadius: 3,
          ),],*/
        ),
        width: MediaQuery.of(context).size.width ,//* 0.35,
        height: MediaQuery.of(context).size.height * 0.14,
        //margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*ClipRRect(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
                child: Image.network(imgurl)
            ),*/
            Text("$state",textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
                fontSize: 18,

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Confirmed: $confirmed",textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,

                  ),
                ),
                Text("Active : $active",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange[900],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            //SizedBox(height: MediaQuery.of(context).size.height*0.01),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Deceased: $deaths",
                  style:TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),),
                //SizedBox(width: MediaQuery.of(context).size.width*0.01),
                Text("Recovered: $recovered",textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.lightGreen[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
