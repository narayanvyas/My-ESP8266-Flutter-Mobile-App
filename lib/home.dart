import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'builtin-ledblink/builtin_ledblink.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My ESP8266"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Text("Welcome to My ESP8266"),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Builtin LED Blink'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuiltinLed()),
                );
              },
            ),
            ListTile(
              title: Text('LED Blink'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
