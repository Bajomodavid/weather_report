import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_data/models/types/city.dart';

class CityCard extends StatefulWidget {
  final City city;
  CityCard({this.city});
  @override
  _CityCardState createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    String city = widget.city.name;
    String country = widget.city.country;
    String population = widget.city.population;
    population = formatter.format(int.parse(population));
    return Container(
      // color: Colors.blue,
      color: Colors.black38,
      margin: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.all(7),
        child: Column(children: <Widget>[
          // Container(alignment: Alignment.topCenter, child: Text('Abuja, Nigeria', style: TextStyle(color: Colors.white, fontSize: 20),),),
          Container(margin: EdgeInsets.only(top: 10, bottom: 10), alignment: Alignment.topCenter, child: Text("$city ($country)", style: TextStyle(color: Colors.white, fontSize: 20),),),
          Container(margin: EdgeInsets.only(left: 8), child: Text("Population: $population", style: TextStyle(color: Colors.white, fontSize: 18),),),
        ],)
      )
    );
  }
}