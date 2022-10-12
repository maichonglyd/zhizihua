import 'package:flutter_huoshu_app/common/util/app_util.dart';

import '../base_model.dart';
import 'deal_goods.dart';

// 小号
class DealAccountListData extends BaseModel<Data> {
  DealAccountListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Account> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Account>();
      json['list'].forEach((v) {
        list.add(new Account.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  int id;
  int appId;
  int memId;
  String nickname;
  int isDefault;
  int createTime;
  int status;
  int mgMemId;
  num sumMoney;

  Account(
      {this.id,
      this.appId,
      this.memId,
      this.nickname,
      this.isDefault,
      this.createTime,
      this.status,
      this.mgMemId,
      this.sumMoney});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    memId = json['mem_id'];
    nickname = json['nickname'];
    isDefault = json['is_default'];
    createTime = json['create_time'];
    status = json['status'];
    mgMemId = json['mg_mem_id'];
    sumMoney = AppUtil.stringToNum(json['sum_money'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['mem_id'] = this.memId;
    data['nickname'] = this.nickname;
    data['is_default'] = this.isDefault;
    data['create_time'] = this.createTime;
    data['status'] = this.status;
    data['mg_mem_id'] = this.mgMemId;
    data['sum_money'] = this.sumMoney;
    return data;
  }
}
