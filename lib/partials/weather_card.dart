import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:test_data/models/types/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  WeatherCard({this.weather});
  static String getCelsius(temp) {
    temp = int.parse(temp);
    var celsius = (temp-32) * (5/9);
    return celsius.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    // print(this.weather.city);
    // print(this.weather.condition);
    // print(this.weather.temperature);
    var condition = weather.condition;
    DateTime present = DateTime.parse(weather.time);
    var temperature = weather.temperature.toString();
    var max = weather.maxtemp.toString();
    var min = weather.mintemp.toString();
    var time = DateFormat('EEEE, dd MMM yyyy, hh:mm a').format(present);
    return Container(
      // color: Colors.blue,
      color: Colors.black38,
      margin: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.all(7),
        child: Column(children: <Widget>[
          // Container(alignment: Alignment.topCenter, child: Text('Abuja, Nigeria', style: TextStyle(color: Colors.white, fontSize: 20),),),
          Container(margin: EdgeInsets.only(top: 10, bottom: 10), alignment: Alignment.topCenter, child: Text("$time ($condition)", style: TextStyle(color: Colors.white),),),
          Row(children: <Widget>[
            Container(margin: EdgeInsets.only(left: 8), child: Text("Temp: $temperature ℃", style: TextStyle(color: Colors.white),),),
            Container(margin: EdgeInsets.only(left: 8), child: Text("Max Temp: $max ℃", style: TextStyle(color: Colors.white),),),
            Container(margin: EdgeInsets.only(left: 8), child: Text("Min Temp: $min ℃", style: TextStyle(color: Colors.white),),),
          ],)
        ],)
      )
    );
  }
}