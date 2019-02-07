import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

void downloadFile(String url, String fileName) async {
  final path = await _localPath;
  await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  if (permission == PermissionStatus.granted) {
    await FlutterDownloader.enqueue(
      url:
          url,
      savedDir: '$path/',
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  } else {
    print('Permission Deniened!');
  }
}

void shareImage(String path, String fileName) async {
  final ByteData bytes = await rootBundle.load(path);
  await EsysFlutterShare.shareImage(fileName, bytes, 'Share Via');
}

void shareUrl(String url) {
  EsysFlutterShare.shareText(url, 'Share Via');
}
