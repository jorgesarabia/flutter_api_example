import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_exaple/country_card.dart';
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
  static final String host = "https://restcountries.eu/rest/v2/";
  TextEditingController _searchController = TextEditingController();
  List _body = [];
  bool isMatch = false;

  @override
  void initState() {
    super.initState();
    _getCountry("");
    _searchController.addListener(_handleChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              elevation: 5,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                  _theIcon(),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          isMatch
              ? Expanded(
                  child: ListView(
                    children: _countryList(),
                  ),
                )
              : _noMatchCard(),
        ],
      ),
    );
  }

  void _handleChange() {
    final String text = _searchController.text.toString();
    _getCountry(text);
  }

  Widget _noMatchCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "No hay coincidencias",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _theIcon() {
    if (_searchController.text.length > 0) {
      return GestureDetector(
        child: Icon(
          Icons.close,
          color: Colors.blue,
        ),
        onTap: () {
          _searchController.text = "";
        },
      );
    } else {
      return Icon(Icons.search);
    }
  }

  void _getCountry(String name) async {
    String url;
    // This is the call
    if (name.length > 0) {
      url = "${host}name/$name";
    } else {
      url = "${host}all/";
    }

    final http.Response response = await http.get(url);
    // This is for parse the response
    if (response.statusCode != 200) {
      print("${response.body}");
      print("Respuesta fallida\nstatusCode = ${response.statusCode}");
      if (jsonDecode(response.body)['message'].contains("Not Found")) {
        setState(() {
          isMatch = false;
        });
      }
      return;
    }
    // change the state
    setState(() {
      _body = jsonDecode(response.body);
      isMatch = true;
    });
  }

  List<Widget> _countryList() {
    List<Widget> list = [];
    final int length = _body.length < 10 ? _body.length : 10;
    for (int x = 0; x < length; x++) {
      print("${_body[x]}");
      list.add(CountryCard(
        countryName: _body[x]['name'],
        alphaCode: _body[x]['alpha2Code'],
        capital: _body[x]['capital'],
        region: _body[x]['region'],
        subregion: _body[x]['subregion'],
      ));
    }
    return list;
  }
}
