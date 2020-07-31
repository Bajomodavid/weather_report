import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_data/bloc/blocs/storage_bloc.dart';
import 'package:test_data/details.dart';
import 'package:test_data/loader.dart';
import 'package:test_data/models/types/city.dart';
import 'package:test_data/models/types/weather.dart';
import 'package:test_data/partials/city_card.dart';
import 'package:test_data/partials/empty.dart';
import 'package:test_data/partials/weather_card.dart';
import 'package:test_data/screens/auth/login.dart';
import 'package:test_data/screens/home.dart';
import 'package:test_data/screens/profile/user.dart';
import 'utilities/remoteStorage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    // getWeather();
    return MaterialApp(
      routes: {
        '/': (context) => Loader(),
        '/login': (context) => Login(),
        '/home': (context) => MyHomePage(title: 'Weather Report List'),
        '/user': (context) => User(),
        '/details': (context) => Details(),
        '/settings': (context) => Settings(),
      },
      title: 'Weather Report',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage =  StorageBloc();
  

  
  void dispose() {
    super.dispose();
    storage.dispose();
    
  }

  String getBackground() {
    DateTime now = DateTime.now();
    if(now.hour > 17 || now.hour < 4) return 'images/night.jpg';
    if(now.hour < 12) return 'images/cloudy.jpg';
    return 'images/sunny.jpg';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(

      statusBarColor: Colors.black.withOpacity(0),/* set Status bar color in Android devices. */

      // statusBarIconBrightness: Brightness.dark,/* set Status bar icons color in Android devices.*/

      statusBarBrightness: Brightness.dark)/* set Status bar icon color in iOS. */
    );
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Icon(Icons.settings, color: Colors.white,),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Icon(Icons.person_outline, color: Colors.white,),
            ),
          ),
        ],

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBackground()),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
        child: Column( children: <Widget>[
          StreamBuilder<City>(
            stream: storage.city,
            builder: (BuildContext context, AsyncSnapshot<City> snapshot) {
              if(snapshot.hasData) {
                if(snapshot.data.country == null) {
                  return Container(height: 120, color: Colors.transparent, child: EmptyCard(message: ''));
                }
                return CityCard(city: snapshot.data);
              }

              print(snapshot.data);
              return Container(height: 120, color: Colors.transparent, child: EmptyCard(message: '',),);
            }
          ),
          Expanded(
              child: StreamBuilder<List<Weather>>(
                stream: storage.weather,
                builder: (BuildContext context, AsyncSnapshot<List<Weather>> snapshot) {
                  if(snapshot.hasData && snapshot.data.length > 0) {
                    // print(snapshot.data);
                    return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new GestureDetector(
                          onTap:  () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => 
                              Details(
                                weather: snapshot.data[index],
                              )
                            )
                          ),
                          child: new WeatherCard(
                          weather: snapshot.data[index],
                        )
                      );
                      }
                    );
                  }
                  return Container(child: null,);
                }
              ),
            ),
        ],)
      )),
    );
  }
}