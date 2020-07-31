import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User extends StatelessWidget {
  
  String getBackground() {
    DateTime now = DateTime.now();
    if(now.hour > 17 || now.hour < 4) return 'images/night.jpg';
    if(now.hour < 12) return 'images/cloudy.jpg';
    return 'images/sunny.jpg';
  }

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle = TextStyle(color: Colors.black, fontSize: 16, decoration: TextDecoration.none);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBackground()),
            fit: BoxFit.cover,
          ),
        ),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 600,
          width: 350,
          padding: EdgeInsets.all(20),
          child: Column(
            children:<Widget>[
              Center(child: Image.asset('images/dp.jpg', height: 100,)),
              Container(margin:EdgeInsets.only(top: 10), child: Text('Name: Bajomo David Mayowa', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 10), child: Text('Title: Software Engineer', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 10), child: Text('Phone: 09013707125, 09053250174', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 20), child: Text('About me:', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 10), child: Text('I am a fullstack Developer, with experience in several software development technologies.', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 30), child: Text('Project Description:', style:  fontStyle,),),
              Container(margin:EdgeInsets.only(top: 10), child: Text(
                'Flutter app  implementing the following login screen, Index Screen Listing weather conditions for different Times of the Day returned from the Openweather API, User profile screen, With Details screen for weather details and settings screen, Usin BLoC pattern for state management.', style:  fontStyle,),),
            ]
          )
        ),
      ),
    );
  }
}