import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String countryName;
  final String alphaCode;

  CountryCard({
    @required this.countryName,
    @required this.alphaCode,
  });

  @override
  Widget build(BuildContext context) {
    final userDetails = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            "$countryName",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Flexible(
          child: Text(
            "$countryName",
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
            "$countryName",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );

    final photo = Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
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
            child: photo,
          ),
          SizedBox(width: 10),
          Flexible(
            child: userDetails,
          ),
        ],
      ),
    );
  }
}
