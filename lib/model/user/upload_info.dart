import 'dart:io';

import '../base_model.dart';

class ImageUploadInfo extends BaseModel<ImageUploadData> {
  ImageUploadInfo.withSuccessData(data) : super(200, "success", data);

  ImageUploadInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = ImageUploadData.fromJson(jsonRes);
  }
}

class ImageUploadData {
  bool isLocalFile = false;
  File file;
  String filepath;
  String name;
  String fileMd5;
  String id;
  String previewUrl;
  String url;

  ImageUploadData(
      {this.filepath,
      this.name,
      this.fileMd5,
      this.id,
      this.previewUrl,
      this.url});

  ImageUploadData.withFile({this.isLocalFile = true, this.file});

  ImageUploadData.fromJson(Map<String, dynamic> json) {
    filepath = json['filepath'];
    name = json['name'];
    fileMd5 = json['file_md5'];
    id = json['id'];
    previewUrl = json['preview_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filepath'] = this.filepath;
    data['name'] = this.name;
    data['file_md5'] = this.fileMd5;
    data['id'] = this.id;
    data['preview_url'] = this.previewUrl;
    data['url'] = this.url;
    return data;
  }
}
