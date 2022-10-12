import 'package:flutter_huoshu_app/model/base_model.dart';

const int COUPON_CENTER_TYPE_PTB = 1;
const int COUPON_CENTER_TYPE_GAME_COIN = 2;
const int COUPON_CENTER_TYPE_COUPON = 3;

class CouponCenterList extends BaseModel<Data> {
  CouponCenterList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<CouponCenter> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<CouponCenter>();
      json['list'].forEach((v) {
        list.add(CouponCenter.fromJson(v));
      });
    }
  }
}

class CouponCenter {
  num gameId;
  String gameName;
  String icon;
  List<CvCouponBean> cvCoupon;
  num classify;
  String size;
  num userCnt;
  String oneWord;

  CouponCenter.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameName = json['game_name'];
    icon = json['icon'];
    classify = json['classify'];
    size = json['size'];
    userCnt = json['user_cnt'];
    oneWord = json['one_word'];
    if (json['coupon_list'] != null) {
      cvCoupon = List<CvCouponBean>();
      json['coupon_list'].forEach((v) {
        cvCoupon.add(CvCouponBean.fromJson(v));
      });
    }
  }

}

class CvCouponBean {
  num id;
  String title;
  num money;
  num type;
  num condition;
  String conditionDes;
  num gameId;
  num isGet;
  num total;
  num remain;
  String expireDate;
  String expire;
  num endTime;

  CvCouponBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    money = json['money'];
    condition = json['condition'];
    conditionDes = json['condition_des'];
    gameId = json['game_id'];
    isGet = json['is_get'];
    total = json['total'];
    remain = json['remain'];
    expireDate = json['expire_date'];
    expire = json['expire'];
    endTime = null != json['endTime'] ? json['endTime'] : json['end_time'];
  }
}
