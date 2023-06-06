
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutme extends StatefulWidget {
  Aboutme({Key? key}) : super(key: key);
  @override
  _AboutmeState createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  List about = [
    "",
    "Hi! Here we are Susmita,Subina & Tirtha.",
    "We are CSIT student  with a passion for building beautiful and functional applications.",
    "We have used Flask,Flutter,Dart, and Python to build this app.",
    "We made a Movie Recommendation API using Flask which is  used  into SSTFlix to  recommend hybrid  movies.",
    "Sentiment Analysis is used to analyse the sentiment of the movie reviews.",
    "We have  hosted the Flask api in local host which returns a list of movies which we are using in suggest page",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "About Me",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 25.h,
                  width: 40.w,
                  child: Image.asset("assets/images/logo.png")),
              Text(
                "SSTFlix",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                about[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                about[1],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                about[2],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                about[3],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                about[4],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                about[5],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "For any further queries contact me through:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 40.w,
                    height: 5.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("#202020"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async{
                       String url="https://github.com/Susmita65";
                        if (await canLaunch(url)) {
                      await  launch(url,forceSafariVC: false);
                        } else {
                          throw 'Could not launch $url';
                        }
                        },
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: Colors.white,
                      ),
                      label: Text(
                        "GitHub",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    height: 5.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("#4154FC"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async{
                         String url="https://www.linkedin.com/in/suzan-balami-bb4723274/";
                        if (await canLaunch(url)) {
                      await  launch(url,forceSafariVC: false);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.linkedinIn,
                        color: Colors.white,
                      ),
                      label: Text(
                        "LinkedIN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
