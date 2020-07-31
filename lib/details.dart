import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_data/models/types/weather.dart';

class Details extends StatelessWidget {
  final Weather weather;
  Details({this.weather});

  String getBackground() {
    print(weather.time);
    if(DateTime.parse(weather.time).hour > 17 ) return 'images/night.jpg';
    if(weather.condition == 'Light Rain') return 'images/cloudy.jpg';
    if(weather.condition == 'Overcast Clouds') return 'images/cloudy.jpg';
    if(weather.condition == 'Moderate Rain') return 'images/cloudy.jpg';
    if(weather.condition == 'Broken Clouds') return 'images/cloudy.jpg';
    return 'images/sunny.jpg';
  }

  Widget getIcon() {
    if(DateTime.parse(weather.time).hour > 17) {
      if(weather.condition == 'Light Rain' )  return Icon(Icons.cloud, color: Colors.white, size: 100.0,);
      if(weather.condition == 'Moderate Rain' )  return Icon(Icons.cloud_queue, color: Colors.white, size: 100.0,);
      if(weather.condition == 'Broken Clouds' )  return Icon(Icons.cloud_off, color: Colors.white, size: 100.0,);
      return Icon(Icons.brightness_3, color: Colors.white, size: 100.0);
    }
    if(weather.condition == 'Light Rain') return Icon(Icons.cloud, color: Colors.white, size: 100.0);
    if(weather.condition == 'Overcast Clouds') return Icon(Icons.cloud, color: Colors.white, size: 100.0);
    return Icon(Icons.wb_sunny, color: Colors.white, size: 100.0);
  }

  @override
  Widget build(BuildContext context) {
    DateTime present = DateTime.parse(weather.time);
    var time = DateFormat('hh:mm a').format(present);
    String temp = (weather.temperature).round().toString();
    String min = (weather.mintemp).round().toString();
    String max = (weather.maxtemp).round().toString();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getBackground()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: <Widget>[
        Container(margin: EdgeInsets.only(top: 100),child: Center(child: getIcon(),),),
        Container(margin: EdgeInsets.only(top: 5),child: Center(child: Text(weather.condition, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 20),),),),
        Container(margin: EdgeInsets.only(top: 70),child: Center(child: Text('$temp℃', style: TextStyle(color: Colors.white, decoration: TextDecoration.none),),),),
        Container(margin: EdgeInsets.only(top: 40),child: Center(child: Text('Min: $min℃    Max: $max℃', style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 25),),),),
        Container(margin: EdgeInsets.only(top: 50),child: Center(child: Text('$time', style: TextStyle(color: Colors.white, decoration: TextDecoration.none),),),)
      ],),
    );
  }
}