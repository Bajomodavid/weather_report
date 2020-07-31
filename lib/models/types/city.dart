import 'dart:convert';

City weatherFromJson(String str) {
  final jsonData = json.decode(str);
  return City.fromMap(jsonData);
}

String weatherToJson(City data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class City {
  String sunset;
  String sunrise;
  String population;
  String country;
  String name;
  
  City({
    this.sunset,
    this.sunrise,
    this.population,
    this.country,
    this.name,
  });

  factory City.fromMap(json) => new City(
    sunset: json["sunset"].toString(),
    sunrise: json["sunrise"].toString(),
    population: json["population"].toString(),
    name: json["name"],
    country: json["country"],
  );

  Map<String, dynamic> toMap() => {
  };
}