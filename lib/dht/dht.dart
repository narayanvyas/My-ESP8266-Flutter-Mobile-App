import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myesp8266/download_share.dart';
import 'package:myesp8266/route_page.dart';

String c = '';
String f = '';
String h = '';

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

class DHT extends StatefulWidget {
  @override
  _DHTState createState() => _DHTState();
}

class _DHTState extends State<DHT> {
  @override
  void initState() {
    super.initState();
    getSensorData(); // Getting initial state of LED, which is by default on
  }

  String _status = '';
  String url =
      'http://192.168.1.200:80/'; //IP Address which is configured in NodeMCU Sketch
  var response;
  bool progressIndicator = true;

  getSensorData() async {
    try {
      response = await http.get(url + 'dht', headers: {"Accept": "plain/text"});
      if (response.body == 'sensorError') {
        setState(() {
          _status = 'Sensor Not Connected';
          c = '';
          f = '';
          h = '';
          progressIndicator = false;
          displaySnackBar(context, 'Check Sensor Connections!');
        });
      } else {
        setState(() {
          _status = 'Sensor Connected';
          progressIndicator = false;
        });
        c = response.body.substring(0, 4) + '°C';
        print('Celcius: ' + c);
        f = response.body.substring(6, 10) + '°F';
        print('Fahrenheit: ' + f);
        h = response.body.substring(12, 16) + '%';
        print('Humidity: ' + h);
      }
    } catch (e) {
      // If NodeMCU is not connected, it will throw error
      print(e);
      if (this.mounted) {
        setState(() {
          _status = 'NodeMCU Not Connected';
          c = '';
          f = '';
          h = '';
          progressIndicator = false;
          displaySnackBar(context, 'Problem in WiFi Connection');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Temperature And Humidity"), centerTitle: true),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 330.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text('Celsius'),
                        ),
                        Image(
                          image: AssetImage('assets/celsius.png'),
                          width: 70.0,
                          height: 70.0,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: Text(c)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text('Fahrenheit'),
                        ),
                        Image(
                          image: AssetImage('assets/fahrenheit.png'),
                          width: 70.0,
                          height: 70.0,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: Text(c)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text('Humidity'),
                        ),
                        Image(
                          image: AssetImage('assets/humidity.png'),
                          width: 70.0,
                          height: 70.0,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: Text(h))
                      ],
                    ),
                  ),
                ],
              ),
              progressIndicator
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          progressIndicator = true;
                        });
                        getSensorData();
                      },
                      child: Text('Refresh'),
                    ),
                  ],
                ),
              ),
              Text(
                _status,
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
          shareUrl(
              'https://github.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App');
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
            gdPath: 'assets/2_dht_gd.jpeg',
            cdPath: 'assets/2_dht_cd.jpeg',
            gdImgUrl:
                'https://raw.githubusercontent.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/master/Graphical%20Diagram.jpeg',
            gdImgTitle: 'DHT Sensor Graphical Diagram',
            cdImgUrl:
                'https://raw.githubusercontent.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/master/Circuit%20Diagram.jpeg',
            cdImgTitle: 'DHT Sensor Circuit Diagram',
            flutterCodeUrl:
                'https://github.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/blob/master/lib/main.dart',
            flutterDownloadLink:
                'https://github.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/raw/master/lib/main.dart',
            nodemcuCodeUrl:
                'https://github.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/blob/master/NodeMCU_Source_Code/NodeMCU_Source_Code.ino',
            nodemcuDownloadLink:
                'https://github.com/narayanvyas/NodeMCU-Temperature-And-Humidity-With-DHT11-DHT22-Sensor-And-Flutter-App/raw/master/NodeMCU_Source_Code/NodeMCU_Source_Code.ino');
      },
    );
  }
}
