import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File> compressImageFile(
  File file, {
  int imageQuality = 80,
  int imageMinWidth = 1024,
  int imageMinHeight = 1024,
}) async {
  Directory tempDir = await getTemporaryDirectory();
  String fileName = file.absolute.path.split("/").last;
  String targetPath = "${tempDir.path}/$fileName";
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: imageQuality,
    minWidth: imageMinWidth,
    minHeight: imageMinHeight,
    rotate: 0,
  );

  return result;
}
