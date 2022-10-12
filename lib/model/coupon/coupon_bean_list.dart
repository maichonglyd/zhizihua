import '../base_model.dart';

class CouponList extends BaseModel<Data> {
  CouponList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<CouponMod> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<CouponMod>();
      json['list'].forEach((v) {
        list.add(new CouponMod.fromJson(v));
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

//data	Object
//data.gamename	STRING	游戏名
//data.icon	STRING	游戏图标
//data.money	FLOAT	代金券金额
//data.condition	FLOAT	代金券使用条件金额
//data.end_time	INT	代金券过期时间
class CouponMod {
  String gameName;
  String icon;
  String money;
  int appId;
  String condition;
  String content;
  String title;
  int endTime;

  CouponMod(
      {this.gameName,
      this.icon,
      this.money,
      this.condition,
      this.endTime,
      this.content,
      this.appId,
      this.title});

  CouponMod.fromJson(Map<String, dynamic> json) {
    gameName = json['gamename'];
    icon = json['icon'];
    money = json['money'];
    appId = json['app_id'];
    title = json['title'];
    content = json['content'];
    condition = json['condition'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
