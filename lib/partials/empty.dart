import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_data/bloc/blocs/storage_bloc.dart';
import 'package:test_data/utilities/storage.dart';



class EmptyCard extends StatelessWidget {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final String message;
  EmptyCard({this.message});
  static const url = "https://community-open-weather-map.p.rapidapi.com/forecast?q=abuja,ng&units=metric";

  static Map<String, String> getHeaders() {
    return {
      "x-rapidapi-host" : "community-open-weather-map.p.rapidapi.com",
		  "x-rapidapi-key" : "[API_KEY_HERE]"
    };
  }

  Widget icon() {
    if(1 == 1)  {
      return Icon(Icons.timer);
    }
    return Icon(Icons.access_time);
  }

  showToast(BuildContext context, message, color) {
    print(message);
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<dynamic> getWeather(context) async {
    try {
      final response = await http.get(
        url,
        headers: getHeaders()
      );
      if (response.statusCode != 200) {
        showToast(context, 'An API error occured', Colors.red);
      }
      print(response.body);
      await Storage.setString("weather", response.body);
      var city = json.decode(response.body);
      city = city["city"];
      await Storage.setString("city", json.encode(city));
      showToast(context, 'Weather records feched', Colors.green);
      var bloc = StorageBloc();
      bloc.getWeather();
      Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
    } catch(e) {
      print(e);
      showToast(context, 'Please check your network connection', Colors.red);
    }
  }

  Widget build(BuildContext context) {
    // print(this.message);
    var message = this.message;
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldkey,
      body: Container(
        height: 120,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text('Click the button to fetch records $message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                ),
                RaisedButton(onPressed: () => getWeather(context), child: Text('Fetch'), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),), color: Colors.white,)
              ],)
            )
          ),
        ),
      )
    );
  }
}