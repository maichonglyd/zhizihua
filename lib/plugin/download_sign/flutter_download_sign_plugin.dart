import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDownloadSignPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_download_sign_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> ipaSign(String command) async {
    final int result =
        await _channel.invokeMethod('ipaSign', {"command": command});
    return result;
  }
}
