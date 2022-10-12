import '../base_model.dart';

class LotteryDrawData extends BaseModel<Data> {
  LotteryDrawData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int actId;
  AwardAd awardAd;
  int awardId;
  String awardName;
  String costIntegral;
  int freeCnt;
  int goodsId;
  int hasAward;
  int isReal;
  int listOrder;
  AwardAd myAward;
  int myIntegral;
  String objectType;
  String orderId;
  String originalImg;
  int shippingStatus;

  Data(
      {this.actId,
      this.awardAd,
      this.awardId,
      this.awardName,
      this.costIntegral,
      this.freeCnt,
      this.goodsId,
      this.hasAward,
      this.isReal,
      this.listOrder,
      this.myAward,
      this.myIntegral,
      this.objectType,
      this.orderId,
      this.originalImg,
      this.shippingStatus});

  Data.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    awardAd = json['award_ad'] != null
        ? new AwardAd.fromJson(json['award_ad'])
        : null;
    awardId = json['award_id'];
    awardName = json['award_name'];
    costIntegral = json['cost_integral'];
    freeCnt = json['free_cnt'];
    goodsId = json['goods_id'];
    hasAward = json['has_award'];
    isReal = json['is_real'];
    listOrder = json['list_order'];
    myAward = json['my_award'] != null
        ? new AwardAd.fromJson(json['my_award'])
        : null;
    myIntegral = json['my_integral'];
    objectType = json['object_type'];
    orderId = json['order_id'];
    originalImg = json['original_img'];
    shippingStatus = json['shipping_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['act_id'] = this.actId;
    if (this.awardAd != null) {
      data['award_ad'] = this.awardAd.toJson();
    }
    data['award_id'] = this.awardId;
    data['award_name'] = this.awardName;
    data['cost_integral'] = this.costIntegral;
    data['free_cnt'] = this.freeCnt;
    data['goods_id'] = this.goodsId;
    data['has_award'] = this.hasAward;
    data['is_real'] = this.isReal;
    data['list_order'] = this.listOrder;
    if (this.myAward != null) {
      data['my_award'] = this.myAward.toJson();
    }
    data['my_integral'] = this.myIntegral;
    data['object_type'] = this.objectType;
    data['order_id'] = this.orderId;
    data['original_img'] = this.originalImg;
    data['shipping_status'] = this.shippingStatus;
    return data;
  }
}

class AwardAd {
  int count;
  List<AwardAdBean> list;

  AwardAd({this.count, this.list});

  AwardAd.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<AwardAdBean>();
      json['list'].forEach((v) {
        list.add(new AwardAdBean.fromJson(v));
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

class AwardAdBean {
  int actId;
  String address;
  List<String> adminNote;
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

  AwardAdBean(
      {this.actId,
      this.address,
      this.adminNote,
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

  AwardAdBean.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    address = json['address'];
    adminNote = json['admin_note'].cast<String>();
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
    data['admin_note'] = this.adminNote;
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
