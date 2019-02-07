import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myesp8266/download_share.dart';

class BuiltinLedCode extends StatefulWidget {
  @override
  _BuiltinLedCodeState createState() => _BuiltinLedCodeState();
}

class _BuiltinLedCodeState extends State<BuiltinLedCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Code"),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: 'https://www.narayanvyas.org/demo.html',
          javascriptMode: JavascriptMode.unrestricted,
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: FloatingActionButton(
                child: Icon(Icons.share),
                onPressed: () {
                  shareUrl('https://www.narayanvyas.org/demo.html');
                },
              ),
            ),
          ],
        ));
  }
}
