import '../base_model.dart';

class LotteryIndexData extends BaseModel<Data> {
  LotteryIndexData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String actId;
  Award award;
  AwardList awardAd;
  String costIntegral;
  int endTime;
  int freeCnt;
  AwardList myAward;
  int myIntegral;
  String pointerImg;
  String rouletteImg;
  int startTime;

  Data(
      {this.actId,
      this.award,
      this.awardAd,
      this.costIntegral,
      this.endTime,
      this.freeCnt,
      this.myAward,
      this.myIntegral,
      this.pointerImg,
      this.rouletteImg,
      this.startTime});

  Data.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    award = json['award'] != null ? new Award.fromJson(json['award']) : null;
    awardAd = json['award_ad'] != null
        ? new AwardList.fromJson(json['award_ad'])
        : null;
    costIntegral = json['cost_integral'];
    endTime = json['end_time'];
    freeCnt = json['free_cnt'];
    myAward = json['my_award'] != null
        ? new AwardList.fromJson(json['my_award'])
        : null;
    myIntegral = json['my_integral'];
    pointerImg = json['pointer_img'];
    rouletteImg = json['roulette_img'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['act_id'] = this.actId;
    if (this.award != null) {
      data['award'] = this.award.toJson();
    }
    if (this.awardAd != null) {
      data['award_ad'] = this.awardAd.toJson();
    }
    data['cost_integral'] = this.costIntegral;
    data['end_time'] = this.endTime;
    data['free_cnt'] = this.freeCnt;
    if (this.myAward != null) {
      data['my_award'] = this.myAward.toJson();
    }
    data['my_integral'] = this.myIntegral;
    data['pointer_img'] = this.pointerImg;
    data['roulette_img'] = this.rouletteImg;
    data['start_time'] = this.startTime;
    return data;
  }
}

class Award {
  int count;
  List<AwardBean> list;

  Award({this.count, this.list});

  Award.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<AwardBean>();
      json['list'].forEach((v) {
        list.add(new AwardBean.fromJson(v));
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

class AwardBean {
  int actId;
  String awardName;
  int goodsId;
  int id;
  int limitCnt;
  int listOrder;
  int rate;
  int remainCnt;
  int totalCnt;

  AwardBean(
      {this.actId,
      this.awardName,
      this.goodsId,
      this.id,
      this.limitCnt,
      this.listOrder,
      this.rate,
      this.remainCnt,
      this.totalCnt});

  AwardBean.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    awardName = json['award_name'];
    goodsId = json['goods_id'];
    id = json['id'];
    limitCnt = json['limit_cnt'];
    listOrder = json['list_order'];
    rate = json['rate'];
    remainCnt = json['remain_cnt'];
    totalCnt = json['total_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['act_id'] = this.actId;
    data['award_name'] = this.awardName;
    data['goods_id'] = this.goodsId;
    data['id'] = this.id;
    data['limit_cnt'] = this.limitCnt;
    data['list_order'] = this.listOrder;
    data['rate'] = this.rate;
    data['remain_cnt'] = this.remainCnt;
    data['total_cnt'] = this.totalCnt;
    return data;
  }
}

class AwardList {
  int count;
  List<AwardListBean> list;

  AwardList({this.count, this.list});

  AwardList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<AwardListBean>();
      json['list'].forEach((v) {
        list.add(new AwardListBean.fromJson(v));
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

class AwardListBean {
  int actId;
  String address;

  String avatar;
  String awardName;
  int city;
  String code;
  int confirmTime;
  String consignee;
  int country;
  int createTime;
  int district;
  String email;
  int flag;
  int goodsId;
  String goodsName;
  String goodsType;
  int id;
  int integral;
  String invoiceNo;
  int isReal;
  int memId;
  String mobile;
  String nickname;
  int num;
  String objectType;
  String orderId;
  String originalImg;
  int province;
  String regMobile;
  String shippingCode;
  String shippingName;
  String shippingPrice;
  int shippingStatus;
  int shippingTime;
  int status;
  int town;
  int updateTime;
  String userNote;
  String username;
  String zipcode;

  AwardListBean(
      {this.actId,
      this.address,
      this.avatar,
      this.awardName,
      this.city,
      this.code,
      this.confirmTime,
      this.consignee,
      this.country,
      this.createTime,
      this.district,
      this.email,
      this.flag,
      this.goodsId,
      this.goodsName,
      this.goodsType,
      this.id,
      this.integral,
      this.invoiceNo,
      this.isReal,
      this.memId,
      this.mobile,
      this.nickname,
      this.num,
      this.objectType,
      this.orderId,
      this.originalImg,
      this.province,
      this.regMobile,
      this.shippingCode,
      this.shippingName,
      this.shippingPrice,
      this.shippingStatus,
      this.shippingTime,
      this.status,
      this.town,
      this.updateTime,
      this.userNote,
      this.username,
      this.zipcode});

  AwardListBean.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    address = json['address'];

    avatar = json['avatar'];
    awardName = json['award_name'];
    city = json['city'];
    code = json['code'];
    confirmTime = json['confirm_time'];
    consignee = json['consignee'];
    country = json['country'];
    createTime = json['create_time'];
    district = json['district'];
    email = json['email'];
    flag = json['flag'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    goodsType = json['goods_type'];
    id = json['id'];
    integral = json['integral'];
    invoiceNo = json['invoice_no'];
    isReal = json['is_real'];
    memId = json['mem_id'];
    mobile = json['mobile'];
    nickname = json['nickname'];
    num = json['num'];
    objectType = json['object_type'];
    orderId = json['order_id'];
    originalImg = json['original_img'];
    province = json['province'];
    regMobile = json['reg_mobile'];
    shippingCode = json['shipping_code'];
    shippingName = json['shipping_name'];
    shippingPrice = json['shipping_price'];
    shippingStatus = json['shipping_status'];
    shippingTime = json['shipping_time'];
    status = json['status'];
    town = json['town'];
    updateTime = json['update_time'];
    userNote = json['user_note'];
    username = json['username'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['act_id'] = this.actId;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['award_name'] = this.awardName;
    data['city'] = this.city;
    data['code'] = this.code;
    data['confirm_time'] = this.confirmTime;
    data['consignee'] = this.consignee;
    data['country'] = this.country;
    data['create_time'] = this.createTime;
    data['district'] = this.district;
    data['email'] = this.email;
    data['flag'] = this.flag;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_type'] = this.goodsType;
    data['id'] = this.id;
    data['integral'] = this.integral;
    data['invoice_no'] = this.invoiceNo;
    data['is_real'] = this.isReal;
    data['mem_id'] = this.memId;
    data['mobile'] = this.mobile;
    data['nickname'] = this.nickname;
    data['num'] = this.num;
    data['object_type'] = this.objectType;
    data['order_id'] = this.orderId;
    data['original_img'] = this.originalImg;
    data['province'] = this.province;
    data['reg_mobile'] = this.regMobile;
    data['shipping_code'] = this.shippingCode;
    data['shipping_name'] = this.shippingName;
    data['shipping_price'] = this.shippingPrice;
    data['shipping_status'] = this.shippingStatus;
    data['shipping_time'] = this.shippingTime;
    data['status'] = this.status;
    data['town'] = this.town;
    data['update_time'] = this.updateTime;
    data['user_note'] = this.userNote;
    data['username'] = this.username;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
