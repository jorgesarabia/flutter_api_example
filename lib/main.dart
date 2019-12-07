import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static final String host = "https://restcountries.eu/rest/v2/";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _getAllCountries,
                color: Colors.green,
                child: Text("Get all"),
              ),
              SizedBox(width: 10),
              RaisedButton(
                onPressed: _getArgentina,
                color: Colors.amber,
                child: Text("Get Argentina"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _getAllCountries() async {
    print("Get all the countries");
    final String url = "${host}all";
    // This is the call
    final response = await http.get(url);
    // This is for parse the response
    final List<dynamic> body = jsonDecode(response.body);
    // This is the way to acces to the datas
    body.forEach((field) {
      print(field['name']);
    });
  }

  void _getArgentina() async {
    print("Get one country (Argentina in this case)");
    final String url = "${host}name/Argentina";
    // This is the call
    final response = await http.get(url);
    // This is for parse the response
    final body = jsonDecode(response.body)[0];
    // This is the way to acces to the datas
    print(body['name']);
  }
}
