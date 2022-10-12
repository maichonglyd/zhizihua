import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import '../base_model.dart';

class VipRecordList extends BaseModel<Data> {
  VipRecordList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

//data.count	String	数量
//data.list	Array	列表
//data.list.id	String	ID
//data.list.vip_name	String	商品名称
//data.list.pay_time	String	购买时间
//data.list.end_time	String	有效期
//data.list.payway_name	String	支付方式	支付宝
class Data {
  int count;
  List<RecordMod> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<RecordMod>();
      json['list'].forEach((v) {
        list.add(new RecordMod.fromJson(v));
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

class RecordMod {
  int id;
  String vipName;
  int payTime;
  int endTime;
  String paywayName;
  //类型 0非会员 1日卡 2周卡 3月卡 4季卡 5年卡
  int vipType;

  RecordMod(
      {this.id,
      this.vipName,
      this.payTime,
      this.endTime,
      this.vipType,
      this.paywayName});

  RecordMod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vipName = json['vip_name'];
    vipType = json['vip_type'];
    payTime = json['pay_time'];
    endTime = json['end_time'];
    paywayName = json['payway_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vip_name'] = this.vipName;
    data['pay_time'] = this.payTime;
    data['end_time'] = this.endTime;
    data['payway_name'] = this.paywayName;
    return data;
  }

  @override
  String toString() {
    return 'RecordMod{id: $id, vipName: $vipName, payTime: $payTime, endTime: $endTime, paywayName: $paywayName}';
  }
}
