import 'dart:convert';

Weather weatherFromJson(String str) {
  final jsonData = json.decode(str);
  return Weather.fromMap(jsonData['list']);
}

String weatherToJson(Weather data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Weather {
  String condition;
  String city;
  String time;
  var temperature;
  var maxtemp;
  var mintemp;

  
  Weather({
    this.condition,
    this.city,
    this.time,
    this.temperature,
    this.maxtemp,
    this.mintemp,
  });

  factory Weather.fromMap(Map<String, dynamic> json) => new Weather(
    condition: allWordsCapitilize(json["weather"][0]["description"]),
    city: json["city"],
    time: json["dt_txt"],
    temperature: json["main"]["temp"],
    maxtemp: json["main"]["temp_max"],
    mintemp: json["main"]["temp_min"],
  );

  Map<String, dynamic> toMap() => {
  };

  static String getCelsius(temp) {
    var celsius = ((temp-32) * 5)/9;
    return celsius.toString();
  }

  static String allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}