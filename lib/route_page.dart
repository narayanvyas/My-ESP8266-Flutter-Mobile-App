import 'package:flutter/material.dart';
import 'package:myesp8266/builtin-ledblink/builtin_ledblink.dart';
import 'package:myesp8266/code_page.dart';
import 'package:myesp8266/image_page.dart';
import 'package:myesp8266/servo-motor/servo_motor.dart';

class MainPageRoute {
  BuildContext context;
  final String mainPageCode;
  MainPageRoute({this.context, this.mainPageCode}) {
    if (mainPageCode == 'builtin_led') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => BuiltinLed()));
    } else if (mainPageCode == 'servo_motor') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ServoMotor()));
    }
  }
}

class RoutePage {
  final BuildContext context;
  final String pageCode;
  final String gdPath;
  final String gdImgUrl;
  final String gdImgTitle;
  final String cdPath;
  final String cdImgUrl;
  final String cdImgTitle;
  final String flutterCodeUrl;
  final String flutterDownloadLink;
  final String nodemcuCodeUrl;
  final String nodemcuDownloadLink;
  RoutePage(
      {this.context,
      this.pageCode,
      this.gdPath,
      this.gdImgUrl,
      this.gdImgTitle,
      this.cdPath,
      this.cdImgUrl,
      this.cdImgTitle,
      this.flutterCodeUrl,
      this.flutterDownloadLink,
      this.nodemcuCodeUrl,
      this.nodemcuDownloadLink}) {
    if (pageCode == 'graphicsPage') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ImagePage(
                imagePath: gdPath,
                imageUrl: gdImgUrl,
                imageTitle: gdImgTitle,
                pageTitle: 'Graphical Diagram',
              )));
    } else if (pageCode == 'circuitsPage') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ImagePage(
                imagePath: cdPath,
                imageUrl: cdImgUrl,
                imageTitle: cdImgTitle,
                pageTitle: 'Circuit Diagram',
              )));
    } else if (pageCode == 'flutterPage') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => CodePage(
                codeUrl: flutterCodeUrl,
                downloadLink: flutterDownloadLink,
                pageTitle: 'Flutter Source Code',
              )));
    } else if (pageCode == 'nodemcuPage') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => CodePage(
                codeUrl: nodemcuCodeUrl,
                downloadLink: nodemcuDownloadLink,
                pageTitle: 'NodeMCU Source Code',
              )));
    }
  }
}
