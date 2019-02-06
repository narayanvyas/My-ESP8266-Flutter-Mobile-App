import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import './code.dart';
import 'package:image_picker_saver/image_picker_saver.dart';

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
            Container(
              child: Image.asset('assets/1_builtin_led_gd.jpeg')
            ),
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
                _onImageSaveButtonPressed(
                    'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Breadboard%20Diagram.jpeg');
              },
            ),
            RaisedButton(
              child: Text("Share Image"),
              onPressed: () async {
                final ByteData bytes = await rootBundle.load('assets/1_builtin_led_gd.jpeg');
                await EsysFlutterShare.shareImage('graphical_diagram.jpeg', bytes, 'Graphical Diagram');
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

void _onImageSaveButtonPressed(String url) async {
  var response = await http.get(url);
  var filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  var savedFile = File.fromUri(Uri.file(filePath));
  print(savedFile);
}
