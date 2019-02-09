import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myesp8266/download_share.dart';
import 'package:myesp8266/route_page.dart';

//Code for Snackbar
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

class BuiltinLed extends StatefulWidget {
  @override
  _BuiltinLedState createState() => _BuiltinLedState();
}

class _BuiltinLedState extends State<BuiltinLed> {
  @override
  void initState() {
    super.initState();
    getInitLedState(); // Getting initial state of LED, which is by default on
  }

  String _status = '';
  String url =
      'http://192.168.1.200:80/'; //IP Address which is configured in NodeMCU Sketch
  var response;

  getInitLedState() async {
    try {
      response = await http.get(url, headers: {"Accept": "plain/text"});
      setState(() {
        _status = 'On';
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      if (this.mounted) {
        setState(() {
          _status = 'Not Connected';
        });
      }
    }
  }

  toggleLed() async {
    try {
      response = await http.get(url + 'led', headers: {"Accept": "plain/text"});
      setState(() {
        _status = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  turnOnLed() async {
    try {
      response =
          await http.get(url + 'led/on', headers: {"Accept": "plain/text"});
      setState(() {
        _status = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  turnOffLed() async {
    try {
      response =
          await http.get(url + 'led/off', headers: {"Accept": "plain/text"});
      setState(() {
        _status = response.body;
        print(response.body);
      });
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      displaySnackBar(context, 'Module Not Connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Builtin LED Blink"), centerTitle: true),
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
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: toggleLed,
                      child: Text('Toggle LED'),
                    ),
                    RaisedButton(
                      onPressed: turnOnLed,
                      child: Text('Turn LED On'),
                    ),
                    RaisedButton(
                      onPressed: turnOffLed,
                      child: Text('Turn LED Off'),
                    ),
                  ],
                ),
              ),
              Text(
                'LED Status: $_status',
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'shareBtn',
        child: Icon(Icons.share),
        onPressed: () {
          shareUrl('https://github.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App');
        },
      ),
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
                'https://github.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/raw/master/Graphical%20Diagram.jpeg',
            gdImgTitle: 'Builtin LED Blink Graphical Diagram',
            cdImgUrl:
                'https://github.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/raw/master/Circuit%20Diagram.jpeg',
            cdImgTitle: 'Builtin LED Blink Circuit Diagram',
            flutterCodeUrl:
                'https://github.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/blob/master/lib/main.dart',
            flutterDownloadLink:
                'https://raw.githubusercontent.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/master/lib/main.dart',
            nodemcuCodeUrl:
                'https://github.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/blob/master/NodeMCU_Source_Code/NodeMCU_Source_Code.ino',
            nodemcuDownloadLink:
                'https://raw.githubusercontent.com/narayanvyas/NodeMCU-ESP8266-Builtin-LED-Control-With-Flutter-App/master/NodeMCU_Source_Code/NodeMCU_Source_Code.ino');
      },
    );
  }
}
