import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_data/models/types/city.dart';
import 'package:test_data/models/types/weather.dart';
import 'package:test_data/utilities/remoteStorage.dart';
import 'package:test_data/utilities/storage.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String chosen = 'Abuja';
  
  String getBackground() {
    DateTime now = DateTime.now();
    if(now.hour > 17 || now.hour < 4) return 'images/night.jpg';
    if(now.hour < 12) return 'images/cloudy.jpg';
    return 'images/sunny.jpg';
  }

  getCity() async {
    var city = await Storage.getString('city');
    if(city != null) {
      City value = city;
      setState(() {
        chosen = value.name;
      });
    }
  }

  setCity(String city) async {
    city = city.toLowerCase();
    print(city);
    await Storage.setString('location', city);
    await RemoteStorage.getData();
    Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    getCity();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Settings"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBackground()),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 150, left: 80, right: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 140,
            child: Center(child: Column(children: [
              Container(margin: EdgeInsets.only(top: 30), child: Text("Change City", style: TextStyle(fontWeight: FontWeight.bold),),),
              DropdownButton<String>(
                value: chosen,
                items: <String>['Abuja', 'Lagos'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    chosen = value;
                  });
                  setCity(value);
                },
              ),

            ])
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 150, left: 80, right: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 140,
            child: Center(child: Column(children: [
              Container(
                margin: EdgeInsets.only(top:45),
                child: RaisedButton(
                  onPressed: () async {
                    await Storage.clear();
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                  },
                  child: Text("Logout", style: TextStyle(color: Colors.white),),
                  color: Colors.deepPurple,
                )
              ,)
            ])
            )
          )
        ],),
      ),
    );
  }
}