import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_data/main.dart';
import 'package:test_data/screens/auth/login.dart';
import 'package:test_data/utilities/storage.dart';


class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}


class _LoaderState extends State<Loader>{
  Widget chosen = Center(child: 
    Container(
      margin: const EdgeInsets.all(20),
      child: new CircularProgressIndicator(),
    )
  );
  
  @override
  void initState() {
    super.initState();
    init();
  }
  
  init() async {
    var val = await Storage.getBool('logged');  
    if(val == true) {
      setState(() {
        chosen = MyHomePage(title: 'Weather Report List');
      });
    }
    else {
      setState(() {
        chosen = Login();
      });
    }
  }
  
  Widget build(BuildContext context) {
    return chosen;
  }
}