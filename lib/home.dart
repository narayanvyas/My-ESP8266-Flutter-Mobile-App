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
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
        appBar: AppBar(
          title: Text("My ESP8266"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {},
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
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
            child: GridView.extent(
          childAspectRatio: 1.3,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 19.0),
          mainAxisSpacing: 20.0,
          maxCrossAxisExtent: 200.0,
          addAutomaticKeepAlives: true,
          crossAxisSpacing: 20.0,
          children: <Widget>[
            projectGridBlock("PIR SENSOR"),
            projectGridBlock("SERVO MOTOR"),
            projectGridBlock("STEPPER MOT."),
            projectGridBlock("ARDUINO UNO"),
          ],
        )));
  }

  Widget projectGridBlock(String text) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/images/bg/project-block-bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(255, 255, 255, 0.7), BlendMode.lighten),
                repeat: ImageRepeat.noRepeat)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => BuiltinLed()));
      },
    );
  }
}
