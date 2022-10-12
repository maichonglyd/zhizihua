import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_record_bean.dart';

//TODO replace with your own action
enum CouponListAction { action, updateRecordList, getCouponList }

class CouponListActionCreator {
  static Action onAction() {
    return const Action(CouponListAction.action);
  }

  static Action getCouponList(int page) {
    return Action(CouponListAction.getCouponList, payload: page);
  }

  static Action updateRecordList(List<GameRechargeBean> recordList) {
    return Action(CouponListAction.updateRecordList, payload: recordList);
  }
}
