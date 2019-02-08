import 'package:flutter/material.dart';
import 'package:myesp8266/navigation_menus.dart';
import 'route_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext scaffoldContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      appBar: AppBar(
        title: Text("NodeMCU With Flutter"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: NavigationMenus(),
      ),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return Container(
            child: GridView.extent(
          childAspectRatio: 1.3,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 19.0),
          mainAxisSpacing: 20.0,
          maxCrossAxisExtent: 200.0,
          addAutomaticKeepAlives: true,
          crossAxisSpacing: 20.0,
          children: <Widget>[
            projectGridBlock('Builtin LED Blink', 'builtin_led'),
            projectGridBlock("SERVO MOTOR", 'servo_motor'),
            projectGridBlock("STEPPER MOT.", 'builtin_led'),
            projectGridBlock("ARDUINO UNO", 'servo_motor'),
          ],
        ));
      }),
    );
  }

  Widget projectGridBlock(String text, String mainPageCode) {
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
        MainPageRoute(context: context, mainPageCode: mainPageCode);
      },
    );
  }
}
