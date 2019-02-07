import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:myesp8266/download_share.dart';

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

class ImagePage extends StatefulWidget {
  final String imagePath;
  final String imageUrl;
  final String imageTitle;
  final String pageTitle;
  ImagePage({Key key, this.imagePath, this.imageUrl, this.imageTitle, this.pageTitle}): super(key: key);
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle), centerTitle: true),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return Center(
          child: ListView(
            children: <Widget>[
              Container(child: Image.asset(widget.imagePath)),
              RaisedButton(
                child: Text("Download Image"),
                onPressed: () {
                  downloadFile(
                      widget.imageUrl,
                      widget.imageTitle);
                  FlutterDownloader.registerCallback((id, status, progress) {
                    print(progress);
                    if (status == DownloadTaskStatus.failed) {
                      displaySnackBar(scaffoldContext, 'Downloaded Failed');
                    } else if (status == DownloadTaskStatus.complete) {
                      displaySnackBar(context, 'Download Completed');
                    }
                  });
                },
              ),
              RaisedButton(
                child: Text("Share Image"),
                onPressed: () async {
                  shareImage(
                      widget.imagePath, 'graphical_diagram.jpeg');
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}