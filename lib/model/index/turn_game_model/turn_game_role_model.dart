import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class TurnGameRoleModel extends BaseModel<Data> {
  TurnGameRoleModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<TurnGameRoleBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<TurnGameRoleBean>();
      json['list'].forEach((v) {
        list.add(TurnGameRoleBean.fromJson(v));
      });
    }
  }
}

class TurnGameRoleBean {
  num roleId;
  String roleName;

  TurnGameRoleBean.fromJson(Map<String, dynamic> json) {
    roleId = json['mg_role_id'];
    roleName = json['mg_role_name'];
  }
}

