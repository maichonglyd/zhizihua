import 'package:flutter_huoshu_app/model/base_model.dart';

class CouponGameList extends BaseModel<Data> {
  CouponGameList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data{
  int count;
  List<CvCoupon> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<CvCoupon>();
      json['list'].forEach((v) {
        list.add(CvCoupon.fromJson(v));
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

class CvCoupon {
  num id;
  String title;
  num money;
  num condition;
  String conditionDes;
  num gameId;
  num isGet;

  CvCoupon();

  CvCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    money = json['money'];
    condition = json['condition'];
    conditionDes = json['condition_des'];
    gameId = json['game_id'];
    isGet = json['is_get'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
