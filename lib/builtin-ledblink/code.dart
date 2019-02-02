import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class BuiltinLedCode extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//         url: 'https://narayanvyas.org/demo.html',
//         appBar: new AppBar(
//           title: new Text("Builtin LED Code"),
//         ),
//         appCacheEnabled: true,
//         withZoom: true,

//         );
//   }
// }

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          print("Hello");
        },
      ),
    );
  }
}
