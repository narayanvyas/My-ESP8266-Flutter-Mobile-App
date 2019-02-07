import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './code.dart';
import 'package:myesp8266/download_share.dart';

class BuiltinLed extends StatefulWidget {
  @override
  _BuiltinLedState createState() => _BuiltinLedState();
}

class _BuiltinLedState extends State<BuiltinLed> {
  String _status = "";
  String _btnText = "LED-";
  String url = 'http://192.168.1.200:80/';
  var response;

  //function to make http requests
  ledRequest() async {
    response = await http.get(url + 'led', headers: {"Accept": "plain/text"});

    setState(() {
      _status = response.body;
      print(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Builtin LED Blink"), centerTitle: true),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(child: Image.asset('assets/1_builtin_led_gd.jpeg')),
            RaisedButton(
              child: Text("View Code"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuiltinLedCode()),
                );
              },
            ),
            RaisedButton(
              child: Text("Download Image"),
              onPressed: () {
                downloadFile(
                    'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Breadboard%20Diagram.jpeg',
                    'Builtin LED Blink Graphical Diagram');
              },
            ),
            RaisedButton(
              child: Text("Share Image"),
              onPressed: () async {
                shareImage('assets/1_builtin_led_gd.jpeg',
                    'graphical_diagram.jpeg');
              },
            ),
            Text(
              'My LED ',
            ),
            RaisedButton(
              onPressed: ledRequest,
              child: Text(_btnText + _status),
            ),
          ],
        ),
      ),
    );
  }
}
