import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myesp8266/route_page.dart';

BuildContext scaffoldContext;
displaySnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
    ),
  );
  Scaffold.of(scaffoldContext).showSnackBar(snackBar);
}

class ServoMotor extends StatefulWidget {
  @override
  _ServoMotorState createState() => _ServoMotorState();
}

class _ServoMotorState extends State<ServoMotor> {
  String _status = "";
  String _btnText = "LED-";
  String url = 'http://192.168.1.200:80/';
  var response;

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
      appBar: AppBar(title: Text("Servo Motor"), centerTitle: true),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 350.0,
                  child: GridView.extent(
                    childAspectRatio: 1.3,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 19.0),
                    mainAxisSpacing: 20.0,
                    maxCrossAxisExtent: 200.0,
                    addAutomaticKeepAlives: true,
                    crossAxisSpacing: 20.0,
                    children: <Widget>[
                      projectGridBlock("Graphical Diagram", 'graphicsPage'),
                      projectGridBlock("Circuit Diagram", 'circuitsPage'),
                      projectGridBlock("Flutter Source Code", 'flutterPage'),
                      projectGridBlock("NodeMCU Source Code", 'nodemcuPage'),
                    ],
                  )),
              Text(
                'My LED ',
              ),
              RaisedButton(
                onPressed: ledRequest,
                child: Text(_btnText + _status),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget projectGridBlock(String text, String pageCode) {
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
        RoutePage(
            context: context,
            pageCode: pageCode,
            gdPath: 'assets/1_builtin_led_gd.jpeg',
            cdPath: 'assets/1_builtin_led_cd.jpeg',
            gdImgUrl:
                'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Breadboard%20Diagram.jpeg',
            gdImgTitle: 'Builtin LED Blink Graphical Diagram',
            cdImgUrl:
                'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Breadboard%20Diagram.jpeg',
            cdImgTitle: 'Builtin LED Blink Circuit Diagram',
            flutterCodeUrl: 'https://www.narayanvyas.org/demo.html',
            flutterDownloadLink:
                'https://github.com/narayanvyas/My-ESP8266-Flutter-Mobile-App/blob/master/lib/home.dart',
            nodemcuCodeUrl: 'https://www.narayanvyas.org/demo.html',
            nodemcuDownloadLink:
                'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Source_Code/Source_Code.ino');
      },
    );
  }
}
