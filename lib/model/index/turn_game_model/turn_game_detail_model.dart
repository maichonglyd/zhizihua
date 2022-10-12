import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';

class TurnGameDetailModel extends BaseModel<Data> {
  TurnGameDetailModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num startTime;
  num endTime;
  num highestReward;
  TurnGame game;
  List<TurnWelfareBean> welfareList;

  Data.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    highestReward = json['highest_reward'];
    game = TurnGame.fromJson(json['game']);

    if (json['welfare'] != null) {
      welfareList = List<TurnWelfareBean>();
      json['welfare'].forEach((v) {
        welfareList.add(TurnWelfareBean.fromJson(v));
      });
    }
  }
}

class TurnWelfareBean {
  num startCharge;
  num endCharge;
  num totalValue;

  List<TurnCouponBean> couponList = [];
  List<TurnPropBean> propList = [];

  TurnWelfareBean.fromJson(Map<String, dynamic> json) {
    startCharge = json['start_charge'];
    endCharge = json['end_charge'];
    totalValue = json['total_value'];

    if (json['coupon_list'] != null) {
      couponList = List<TurnCouponBean>();
      json['coupon_list'].forEach((v) {
        couponList.add(TurnCouponBean.fromJson(v));
      });
    }

    if (json['props_list'] != null) {
      propList = List<TurnPropBean>();
      json['props_list'].forEach((v) {
        propList.add(TurnPropBean.fromJson(v));
      });
    }
  }
}
