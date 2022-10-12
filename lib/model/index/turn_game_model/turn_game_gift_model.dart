import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';

class TurnGameGiftModel extends BaseModel<Data> {
  TurnGameGiftModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<TurnGiftBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<TurnGiftBean>();
      json['list'].forEach((v) {
        list.add(TurnGiftBean.fromJson(v));
      });
    }
  }
}

class TurnGiftBean {
  num id;
  String orderId;
  num memId;
  num switchGameId;
  num switchGameWelfareId;
  num fromGameId;
  num fromGameClassify;
  num toGameId;
  num toGameClassify;
  num toMgRoleId;
  num toMemGameId;
  num status;
  String userNote;
  String adminNote;
  num createTime;
  num updateTime;
  TurnGame fromGame;
  TurnGame toGame;
  List<TurnCouponBean> couponList = [];
  List<TurnPropBean> propList = [];

  TurnGiftBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    memId = json['mem_id'];
    switchGameId = json['switchgame_id'];
    switchGameWelfareId = json['switchgame_welfare_id'];
    fromGameId = json['from_game_id'];
    fromGameClassify = json['from_game_classify'];
    toGameId = json['to_game_id'];
    toGameClassify = json['to_game_classify'];
    toMgRoleId = json['to_mg_role_id'];
    toMemGameId = json['to_mem_game_id'];
    status = json['status'];
    userNote = json['user_note'];
    adminNote = json['admin_note'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    fromGame = TurnGame.fromJson(json['fromgame']);
    toGame = TurnGame.fromJson(json['togame']);

    if (null != json['welfare'] && json['welfare']['coupon_list'] != null) {
      couponList = List<TurnCouponBean>();
      json['welfare']['coupon_list'].forEach((v) {
        couponList.add(TurnCouponBean.fromJson(v));
      });
    }

    if (null != json['welfare'] && json['welfare']['props_list'] != null) {
      propList = List<TurnPropBean>();
      json['welfare']['props_list'].forEach((v) {
        propList.add(TurnPropBean.fromJson(v));
      });
    }
  }
}

class TurnCouponBean {
  String name;
  String icon;
  num listOrder;
  TurnCouponDetailBean detail;

  TurnCouponBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    listOrder = json['list_order'];
    detail = TurnCouponDetailBean.fromJson(json['coupon']);
  }
}

class TurnCouponDetailBean {
  num amount;
  num startTime;
  num endTime;
  num condition;
  num gameId;
  String gameName;

  TurnCouponDetailBean.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    condition = json['condition'];
    gameId = json['game_id'];
    gameName = json['game_name'];
  }
}

class TurnPropBean {
  num listOrder;
  String name;
  String icon;
  num value;
  TurnPropDetailBean detail;

  TurnPropBean.fromJson(Map<String, dynamic> json) {
    listOrder = json['list_order'];
    name = json['name'];
    icon = json['icon'];
    value = json['value'];
    detail = TurnPropDetailBean.fromJson(json['props']);
  }
}

class TurnPropDetailBean {
  String name;
  String icon;

  TurnPropDetailBean.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    icon = json['icon'];
  }
}