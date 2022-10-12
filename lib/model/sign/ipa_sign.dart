import 'dart:io';

import '../base_model.dart';

class IpaSignModel extends BaseModel<Data> {
  IpaSignModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String plist_url;
  String p12_url;
  String mobile_url;
  String p12_content;
  String mobile_content;
  String pk12_pwd;
  String mobileConfigPath;
  String p12Path;
  Data(
      {this.plist_url,
      this.p12_url,
      this.mobile_url,
      this.p12_content,
      this.mobile_content,
      this.pk12_pwd});

  Data.fromJson(Map<String, dynamic> json) {
    plist_url = json['plist_url'];
    p12_url = json['p12_url'];
    mobile_url = json['mobile_url'];
    p12_content = json['p12_content'];
    mobile_content = json['mobile_content'];
    pk12_pwd = json['pk12_pwd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plist_url'] = this.plist_url;
    data['p12_url'] = this.p12_url;
    data['mobile_url'] = this.mobile_url;
    data['p12_content'] = this.p12_content;
    data['mobile_content'] = this.mobile_content;
    data['pk12_pwd'] = this.pk12_pwd;
    return data;
  }
}
