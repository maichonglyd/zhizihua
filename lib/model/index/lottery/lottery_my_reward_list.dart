import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class LotteryMyRewardList extends BaseModel<Data> {
  LotteryMyRewardList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<LotteryMyRewardBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<LotteryMyRewardBean>();
      json['list'].forEach((v) {
        list.add(LotteryMyRewardBean.fromJson(v));
      });
    }
  }
}

class LotteryMyRewardBean {
  num rewardId;
  String rewardIcon;
  String rewardName;
  String orderId;
  num createTime;
  LotteryInKindBean inKind;
  LotteryCouponBean coupon;
  LotteryGiftBean gift;
  LotteryPtbBean ptb;

  LotteryMyRewardBean.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createTime = json['create_time'];
    rewardId = json['award_id'];
    rewardIcon = json['award_icon'];
    rewardName = json['award_name'];
    inKind = null != json['in_kind']
        ? LotteryInKindBean.fromJson(json['in_kind'])
        : null;
    coupon = null != json['coupon']
        ? LotteryCouponBean.fromJson(json['coupon'])
        : null;
    gift = null != json['gift'] ? LotteryGiftBean.fromJson(json['gift']) : null;
    ptb = null != json['ptb'] ? LotteryPtbBean.fromJson(json['ptb']) : null;
  }
}

class LotteryInKindBean {
  num count;
  num shippingStatus;
  String invoiceNo;
  String shippingName;
  String consignee;
  String fullAddress;
  String mobile;

  LotteryInKindBean.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    shippingStatus = json['shipping_status'];
    invoiceNo = json['invoice_no'];
    shippingName = json['shipping_name'];
    consignee = json['consignee'];
    fullAddress = json['full_address'];
    mobile = json['mobile'];
  }
}

class LotteryCouponBean {
  String amount;
  num startTime;
  num endTime;
  String condition;
  num gameId;
  String gameName;
  num isUsed;

  LotteryCouponBean.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toString();
    startTime = json['start_time'];
    endTime = json['end_time'];
    condition = json['condition'].toString();
    gameId = json['game_id'];
    gameName = json['game_name'];
    isUsed = json['is_used'];
  }
}

class LotteryGiftBean {
  num startTime;
  num endTime;
  String content;

  LotteryGiftBean.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    content = json['content'];
  }
}

class LotteryPtbBean {
  num ptbCnt;
  num startTime;
  num endTime;
  num condition;
  num gameId;
  String gameName;
  num isUsed;

  LotteryPtbBean.fromJson(Map<String, dynamic> json) {
    ptbCnt = json['ptb_cnt'];
  }
}

class LotteryMyRewardType {
  static int ptb = 1;
  static int coupon = 2;
  static int gift = 3;
  static int kind = 4;
}

class LotteryMyRewardKindStatus {
  static int undelivered = 1;
  static int delivered = 2;
  static int deliveryFailed = 3;
}

String getLotteryMyRewardKindStatusText(int status) {
  if (LotteryMyRewardKindStatus.deliveryFailed == status) {
    return getText(name: 'textDeliveredFailed');
  } else if (LotteryMyRewardKindStatus.delivered == status) {
    return getText(name: 'textHasDelivered');
  } else {
    return getText(name: 'textNotDelivered');
  }
}

int getLotteryRewardType(LotteryMyRewardBean reward) {
  int type = 0;
  if (null != reward.ptb) {
    type = LotteryMyRewardType.ptb;
  } else if (null != reward.coupon) {
    type = LotteryMyRewardType.coupon;
  } else if (null != reward.gift) {
    type = LotteryMyRewardType.gift;
  } else if (null != reward.inKind) {
    type = LotteryMyRewardType.kind;
  }
  return type;
}
