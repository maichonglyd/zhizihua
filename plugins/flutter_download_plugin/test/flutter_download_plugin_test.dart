import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_download_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterDownloadPlugin.platformVersion, '42');
  });
}
