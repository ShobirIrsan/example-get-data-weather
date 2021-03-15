import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temperature = "loading";
  var humidity = "loading";
  var description = "loading";
  var currently = "loading";
  var windSpeed = "loading";
 
  String _url =
      "http://api.openweathermap.org/data/2.5/weather?q=Medan&appid=814ecc4782b770546f968dd8a8c3f571";
  Future getWeather() async {
    http.Response dataRespon = await http.get(_url);
    var result = jsonDecode(dataRespon.body);
    setState(() {
      temperature = result['main']['temp'].toString();
      description = result['weather'][0]['description'].toString();
      humidity = result['main']['humidity'].toString();
      windSpeed = result['wind']['speed'].toString();
      currently = result['weather'][0]['main'].toString();
    });
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text("Currently in Medan", style: styleFont(14.0)),
                ),
                Text(
                  temperature+"\u00b0",
                  style: styleFont(40.0),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(currently, style: styleFont(14.0)),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text(temperature+"\u00b0"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text(description),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Humidity"),
                  trailing: Text(humidity),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Wind Speed"),
                  trailing: Text(windSpeed),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  TextStyle styleFont(double size) {
    return TextStyle(
        color: Colors.white, fontSize: size, fontWeight: FontWeight.w600);
  }
}
