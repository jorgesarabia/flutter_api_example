import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String countryName;
  final String alphaCode;
  final String region;
  final String subregion;
  final String capital;

  CountryCard({
    @required this.countryName,
    @required this.alphaCode,
    @required this.region,
    @required this.subregion,
    @required this.capital,
  });

  @override
  Widget build(BuildContext context) {
    final countryDetail = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            "$countryName ($region)",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Flexible(
          child: Text(
            "capital: $capital",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFa3a5a7),
            ),
          ),
        ),
        SizedBox(height: 1.0),
        Flexible(
          child: Text(
            "$subregion",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );

    final flag = Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage("https://www.countryflags.io/$alphaCode/flat/64.png"),
        ),
      ),
    );

    return Card(
      elevation: 3.5,
      child: Row(
        children: <Widget>[
          Flexible(
            child: flag,
          ),
          SizedBox(width: 10),
          Flexible(
            child: countryDetail,
          ),
        ],
      ),
    );
  }
}
