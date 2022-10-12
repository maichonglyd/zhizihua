
import 'dart:io';

import 'package:flutter_huoshu_app/model/user/upload_info.dart';

import 'common_dio.dart';

class FileService{
  static Future<ImageUploadInfo> upload(File file) async {
    dynamic response = await CommonDio.upload(file);
    return response;
  }

  static Future<List<ImageUploadInfo>> uploads(List<File> files) async {
    dynamic response = await CommonDio.uploadFiles(files);
    return response;
  }
  static Future<List<ImageUploadInfo>> uploadImageFiles(List<ImageUploadData> fileDatas) async {
    dynamic response = await CommonDio.uploadImageFiles(fileDatas);
    return response;
  }
}