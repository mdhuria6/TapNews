import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class artnews extends StatefulWidget {
  final String url;
  artnews({this.url});
  @override
  _artnewsState createState() => _artnewsState();
}

class _artnewsState extends State<artnews> {

  final Completer<WebViewController> _completer = Completer<WebViewController>(); //Completer<WebViewController> _completer = Completer<WebViewController>();

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
          Opacity(opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
