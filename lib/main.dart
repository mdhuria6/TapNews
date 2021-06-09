import 'package:flutter/material.dart';
import 'news/home.dart';
import 'drawerContents/globalStats.dart';
import 'package:custompopupchoice/custompopupchoice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class tryi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('PopupChoice'),
),
body: Column(
children: [
RaisedButton(
onPressed: () {
//RaisedButton(onPressed: () {
showModalBottomSheet(
backgroundColor: Colors.transparent,
context: context,
builder: (context) => PopupChoice(
heigh: 400,
title: 'More Action',
item: [
CustomListile(
label: 'Edit',
icon: Icon(Icons.edit),
),
CustomListile(
label: 'Search',
icon: Icon(Icons.search),
),
CustomListile(
label: 'Delete',
icon: Icon(Icons.delete),
),
  CustomListile(
    label: 'Edit',
    icon: Icon(Icons.edit),
  ),
  CustomListile(
    label: 'Search',
    icon: Icon(Icons.search),
  ),
  CustomListile(
    label: 'Delete',
    icon: Icon(Icons.delete),
  ),
  CustomListile(
    label: 'Edit',
    icon: Icon(Icons.edit),
  ),
  CustomListile(
    label: 'Search',
    icon: Icon(Icons.search),
  ),
  CustomListile(
    label: 'Delete',
    icon: Icon(Icons.delete),
  ),
  CustomListile(
    label: 'Edit',
    icon: Icon(Icons.edit),
  ),
  CustomListile(
    label: 'Search',
    icon: Icon(Icons.search),
  ),
  CustomListile(
    label: 'Delete',
    icon: Icon(Icons.delete),
  ),
],
onTap: (v) {
if (v.label == 'Edit') {
print('Edit');
}
},
));
//});
},
child: Text('Open Custom Pop Choice'),
)
],
),
);

  }
}
