import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class LotteryActivityInfo extends BaseModel<Data> {
  LotteryActivityInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num lotteryId;
  num drawableCnt;
  List<String> rule;
  List<String> topMsg;
  List<LotteryOpportunityBean> opportunityList;

  Data.fromJson(Map<String, dynamic> json) {
    lotteryId = json['lottery_id'];
    drawableCnt = json['drawable_cnt'];
    rule = json['rule'].cast<String>();
    topMsg = json['top_msg'].cast<String>();

    if (json['opportunity'] != null) {
      opportunityList = List<LotteryOpportunityBean>();
      json['opportunity'].forEach((v) {
        opportunityList.add(LotteryOpportunityBean.fromJson(v));
      });
    }
  }
}

class LotteryOpportunityBean {
  num cnt;
  num giftCnt;
  num ptbCnt;

  LotteryOpportunityBean.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    giftCnt = json['gift_cnt'];
    ptbCnt = json['ptb_cnt'];
  }
}
