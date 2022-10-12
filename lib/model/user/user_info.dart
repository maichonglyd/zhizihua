import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

class UserInfo extends BaseModel<Data> {
  UserInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int memId;
  int mgMemId;
  String avatar;
  String username;
  String nickname;
  num myIntegral;
  int giftCnt;
  int gameCnt;
  double ptbCnt;
  int gmCnt;
  int msgCnt;
  int lastSignTime;
  int signDays;
  int hasIdentify = 1;
  int hasBindMobile;
  String mobile;
  String email;
  int itgPtbRate;
  int hasSign;
  String token;
  String identifyUrl;
  int coupon_cnt;

  Data(
      {this.memId,
      this.mgMemId,
      this.avatar,
      this.username,
      this.nickname,
      this.myIntegral,
      this.giftCnt,
      this.gameCnt,
      this.ptbCnt,
      this.gmCnt,
      this.msgCnt,
      this.lastSignTime,
      this.signDays,
      this.hasIdentify,
      this.hasBindMobile,
      this.mobile,
      this.email,
      this.itgPtbRate,
      this.hasSign,
      this.token,
      this.identifyUrl,
      this.coupon_cnt});

  Data.fromJson(Map<String, dynamic> json) {
    memId = json['mem_id'];
    mgMemId = json['mg_mem_id'];
    avatar = json['avatar'];
    username = json['username'];
    nickname = json['nickname'];
    myIntegral = json['my_integral'];
    giftCnt = json['gift_cnt'];
    gameCnt = json['game_cnt'];
    ptbCnt = double.parse(json['ptb_cnt'].toString());
    gmCnt = json['gm_cnt'];
    msgCnt = json['msg_cnt'];
    lastSignTime = json['last_sign_time'];
    signDays = json['sign_days'];
    hasIdentify = json['has_identify'];
    hasBindMobile = json['has_bind_mobile'];
    mobile = json['mobile'];
    email = json['email'];
    itgPtbRate = json['itg_ptb_rate'];
    hasSign = json['has_sign'];
    token = json['token'];
    identifyUrl = json['identify_url'];
    coupon_cnt = json['coupon_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mem_id'] = this.memId;
    data['mg_mem_id'] = this.mgMemId;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['my_integral'] = this.myIntegral;
    data['gift_cnt'] = this.giftCnt;
    data['game_cnt'] = this.gameCnt;
    data['ptb_cnt'] = this.ptbCnt;
    data['gm_cnt'] = this.gmCnt;
    data['msg_cnt'] = this.msgCnt;
    data['last_sign_time'] = this.lastSignTime;
    data['sign_days'] = this.signDays;
    data['has_identify'] = this.hasIdentify;
    data['has_bind_mobile'] = this.hasBindMobile;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['itg_ptb_rate'] = this.itgPtbRate;
    data['has_sign'] = this.hasSign;
    data['token'] = this.token;
    data['identify_url'] = this.identifyUrl;
    data['coupon_cnt'] = this.coupon_cnt;
    return data;
  }
}
