import 'dart:async';
import 'package:test_data/models/types/city.dart';
import 'package:test_data/models/types/weather.dart';
import 'package:test_data/utilities/storage.dart';

class StorageBloc {
  final _weatherController = StreamController<List<Weather>>.broadcast();
  final _cityController = StreamController<City>.broadcast();

  bool isStopped = false;

  get weather => _weatherController.stream;
  get city => _cityController.stream;

  dispose() {
    _weatherController.close();
    _cityController.close();
  }

  getWeather() async {
    var list = await Storage.getString("weather");
    var cityValue = await Storage.getString("city");
    
    if(list is String || list == null) {
      list = <Weather>[];
      sec5Timer();
    }
 
    _weatherController.sink.add(list);
    _cityController.sink.add(cityValue);
  }

  sec5Timer() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (isStopped) {
        timer.cancel();
      }
      print("Dekhi 5 sec por por kisu hy ni :/");
    });
  }

  StorageBloc() {
    getWeather();
  }
}