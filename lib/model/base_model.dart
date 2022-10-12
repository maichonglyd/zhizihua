import 'dart:convert';

import 'package:flutter_huoshu_app/generated/locale_manager.dart';

class BaseModel<T> {
  int code;
  String msg;
  T data;
  BaseModel(this.code, this.msg, this.data);
  BaseModel.fromJson(jsonRes) {
    try {
      code = jsonRes['code'];
      msg = jsonRes['msg'];
      var result = jsonRes['data'];
      if (result != null) {
        if (result is Map || result is List) {
          initialResult(result);
        } else {
          this.data = result;
        }
      }
    } catch (e, stackTrace) {
      code = 500;
      msg = getText(name: 'textDataDecodeFailed');
      print("数据解析出错：$e");
      print("数据解析出错：$stackTrace");
    }
  }

  void initialResult(jsonRes) {}

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
