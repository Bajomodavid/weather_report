import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_data/models/types/city.dart';
import 'package:test_data/models/types/weather.dart';

class Storage {

  static getString(key) async {
    final data = await SharedPreferences.getInstance();
    var result = data.getString(key);
   
    if(key == "weather") {
      if(result == null) return <Weather>[];
      var value = json.decode(result);
      var list = value["list"] as List;
      if(list == null ) return value["message"];
      List<Weather> weatherList = list.map((i) => Weather.fromMap(i)).toList();
      return weatherList;
    }

    if(key == "city") {
      if(result == null) return City();
      var value = json.decode(result);
      City city = City.fromMap(value);
      return city;
    }

    return result;
  }

  static getBool(key) async {
    final data = await SharedPreferences.getInstance();
    var result = data.getBool(key);
    return result;
  }

  static setString(key, value) async {
    final data = await SharedPreferences.getInstance();
    data.setString(key, value);
  }

  static setBool(key, bool value) async {
    final data = await SharedPreferences.getInstance();
    return data.setBool(key, value);
  }

  static remove(key) async {
    final data = await SharedPreferences.getInstance();
    data.remove(key);
  }

  static clear() async {
    final data = await SharedPreferences.getInstance();
    data.clear();
  }
}