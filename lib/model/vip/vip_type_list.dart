import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import '../base_model.dart';

class VipList extends BaseModel<Data> {
  VipList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

//data.count	String	数量
//data.list	Array	列表
//data.list.id	String	ID
//data.list.name	String	名称
//data.list.icon	String	尊贵标识
//data.list.amount	String	市场价
//data.list.real_amount	String	支付价格	8
//data.list.rights	Array	权益
//data.list.rights.name	String	标题
//data.list.rights.sub_name	String	子标题
//data.list.rights.icon	String	icon
//data.pay_way	Object	支付方式
//data.pay_way.payway	String	支付类型	wxpay
//data.pay_way.name	String	支付名称	微信
//data.pay_way.icon	Str
class Data {
  int count;
  List<VIPMod> list;
  List<PayWayMod> payWays;

  Data({this.count, this.list, this.payWays});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<VIPMod>();
      json['list'].forEach((v) {
        list.add(new VIPMod.fromJson(v));
      });
    }
    if (json['pay_way'] != null) {
      payWays = new List<PayWayMod>();
      json['pay_way'].forEach((v) {
        payWays.add(new PayWayMod.fromJson(v));
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

//data.list.id	String	ID
//data.list.name	String	名称
//data.list.icon	String	尊贵标识
//data.list.amount	String	市场价
//data.list.real_amount	String	支付价格	8
//data.list.rights	Array	权益
//data.list.rights.name	String	标题
//data.list.rights.sub_name	String	子标题
//data.list.rights.icon	String	icon
class VIPMod {
  int id;
  String name;
  String description;
  String icon;
  String amount;
  String realAmount;
  bool isSelected = false;
  List<RightsMod> rights;

  //背景图
  String background;

  //字体颜色值
  String fontColor;

  //类型 0非会员 1日卡 2周卡 3月卡 4季卡 5年卡
  int vipType;

  VIPMod(
      {this.id,
      this.name,
      this.vipType,
      this.description,
      this.icon,
      this.amount,
      this.realAmount,
      this.rights,
      this.background,
      this.fontColor,
      this.isSelected});

  VIPMod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vipType = json['vip_type'];
    description = json['description'];
    background = json['background'];
    fontColor = json['color '];
    icon = json['icon'];
    amount = json['amount'];
    realAmount = json['real_amount'];

    if (json['rights'] != null) {
      rights = new List<RightsMod>();
      json['rights'].forEach((v) {
        rights.add(new RightsMod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['vip_type'] = this.vipType;
    data['icon'] = this.icon;
    data['background'] = this.background;
    data['color'] = this.fontColor;
    data['amount'] = this.amount;
    data['real_amount'] = this.realAmount;

    if (this.rights != null) {
      data['rights'] = this.rights.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//会员权益
class RightsMod {
  String name;
  String subName;
  String icon;

  RightsMod({this.name, this.subName, this.icon});

  RightsMod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subName = json['sub_name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sub_name'] = this.subName;
    data['icon'] = this.icon;
    return data;
  }
}

//data.pay_way.payway	String	支付类型	wxpay
//data.pay_way.name	String	支付名称	微信
//data.pay_way.icon	String	图标	https
//支付方式
class PayWayMod {
  String payWay;
  String name;
  String icon;

  //是否选中
  bool isSelected = false;

  PayWayMod(this.name, this.payWay, this.icon, this.isSelected);

  //自定义构造函数
//  PayWayMod.single(this.name, this.isSelected) {
//    isSelected = false;
//    this.name = "";
//  }
//
//  PayWayMod.noParam();

  PayWayMod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    payWay = json['payway'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['payway'] = this.payWay;
    data['icon'] = this.icon;
    return data;
  }
}
