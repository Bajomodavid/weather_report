import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_data/utilities/storage.dart';

class RemoteStorage {

  static Map<String, String> getHeaders() {
    return {
      "x-rapidapi-host" : "community-open-weather-map.p.rapidapi.com",
		  "x-rapidapi-key" : "[API_KEY_HERE]"
    };
  }

  static getCity() async {
    
  }

  static Future<dynamic> getData() async {
    try {
      String city = await Storage.getString('location');
      if(city == null) {
        city = 'abuja';
      }
      final response = await http.get(
        "https://community-open-weather-map.p.rapidapi.com/forecast?q=$city,ng&units=metric",
        headers: getHeaders()
      );
      if (response.statusCode != 200) {
        return handleHttpError(response.body, response.statusCode);
      }
      return handleResponse(response.body);
    } catch(e) {
      print(e);
    }
  }

  static handleHttpError(body, int code) {
    print(code);
    return handleResponse(body);
  }

  static handleResponse(body) async {
    await Storage.setString("weather", body);
    var city = json.decode(body);
    city = city["city"];
    await Storage.setString("city", json.encode(city));
  }
  
}