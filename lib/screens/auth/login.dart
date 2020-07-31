import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_data/utilities/storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String userInput;
  String passInput;
  bool loading;

  submit() {
    if(userInput == null || passInput == null) return 'Both fiels are required';
    if(userInput != 'aliu' || passInput != 'wuyi') return 'Invalid credentials';
    return true;
  }

  setLogged() async {
    var logged = await Storage.setBool('logged', true);
    print(logged);
  }

  showToast(BuildContext context, message, color) {
    print(message);
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);

  String getBackground() {
    DateTime now = DateTime.now();
    print(now);
    if(now.hour > 17 || now.hour < 4) return 'images/night.jpg';
    if(now.hour < 12) return 'images/cloudy.jpg';
    return 'images/sunny.jpg';
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      obscureText: false,
      style: style,
      onChanged: (value) {
        setState(() {
          userInput = value;
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      onChanged: (value) {
        setState(() {
          passInput = value;
        });
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      // borderRadius: BorderRadius.circular(30.0),
      color: Colors.transparent,
      child: MaterialButton(
        color: Colors.transparent,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          var check = submit();
          if(check is String) {
            return showToast(context, check, Colors.red);
          }
          setLogged();
          showToast(context, 'Login successful!!', Colors.greenAccent);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      key: _scaffoldkey,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(getBackground()),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 175.0, bottom: 230, left: 36, right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 120.0,
                      child: Text(
                        "WEATHER REPORT", 
                        style: TextStyle(
                          backgroundColor: Colors.black.withOpacity(0.1),
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      );
  }
}