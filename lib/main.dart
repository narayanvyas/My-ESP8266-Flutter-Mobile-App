import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: "My ESP8266",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        appBar: AppBar(
          title: Text("My ESP8266"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My LED ',
              ),
              RaisedButton(
                onPressed: ledRequest,
                child: Text(_btnText + _status),
              ),
            ],
          ),
        ));
  }
}
