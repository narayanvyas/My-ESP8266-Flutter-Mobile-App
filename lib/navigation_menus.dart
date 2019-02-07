import 'package:flutter/material.dart';
import 'package:myesp8266/builtin-ledblink/builtin_ledblink.dart';
import 'package:myesp8266/servo-motor/servo_motor.dart';

class NavigationMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image(
            image: AssetImage('assets/header.png'),
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue
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
          title: Text('Servo Motor'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServoMotor()),
            );
          },
        ),
        ListTile(
          title: Text('LED Blink'),
          onTap: () {},
        ),
      ],
    );
  }
}
