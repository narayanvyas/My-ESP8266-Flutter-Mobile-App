import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myesp8266/download_share.dart';

class CodePage extends StatefulWidget {
  final String codeUrl;
  final String downloadLink;
  final String pageTitle;
  CodePage({Key key, this.codeUrl, this.downloadLink, this.pageTitle}): super(key: key);
  @override
  _CodePageState createState() => _CodePageState();
}

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

class _CodePageState extends State<CodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.pageTitle),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return WebView(
            initialUrl: widget.codeUrl,
            javascriptMode: JavascriptMode.unrestricted,
          );
        }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: FloatingActionButton(
                heroTag: 'downloadBtn',
                child: Icon(Icons.file_download),
                onPressed: () {
                  downloadFile(
                      widget.downloadLink,
                      'Download ${widget.pageTitle}');
                  FlutterDownloader.registerCallback((id, status, progress) {
                    print(progress);
                    if (status == DownloadTaskStatus.failed) {
                      displaySnackBar(scaffoldContext, 'Downloaded Failed');
                    } else if (status == DownloadTaskStatus.complete) {
                      displaySnackBar(scaffoldContext, 'Download Completed');
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: FloatingActionButton(
                heroTag: 'shareBtn',
                child: Icon(Icons.share),
                onPressed: () {
                  shareUrl(widget.downloadLink);
                },
              ),
            ),
          ],
        ));
  }
}
