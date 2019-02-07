import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

void downloadFile(String url, String fileName) async {
  final path = await _localPath;
  final taskId = await FlutterDownloader.enqueue(
    url:
        'https://raw.githubusercontent.com/narayanvyas/Human-Detector-With-PIR-HC-SR501-And-Ultrasonic-Sensor-HC-SR04/master/Breadboard%20Diagram.jpeg',
    savedDir: '$path/',
    fileName: fileName,
    showNotification:
        true, // show download progress in status bar (for Android)
    openFileFromNotification:
        true, // click on notification to open downloaded file (for Android)
  );
}

void shareImage(String path, String fileName) async {
  final ByteData bytes = await rootBundle.load(path);
  await EsysFlutterShare.shareImage(
      fileName, bytes, 'Share Via');
}

void shareUrl(String url) {
  EsysFlutterShare.shareText(url, 'Share Via');
}