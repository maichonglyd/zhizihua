import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';

class GameCoinRechargeRecordState
    implements Cloneable<GameCoinRechargeRecordState> {
  bool isShowHead = false;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<Record> records = List();

  @override
  GameCoinRechargeRecordState clone() {
    return GameCoinRechargeRecordState()
      ..isShowHead = isShowHead
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper
      ..records = records;
  }
}

GameCoinRechargeRecordState initState(Map<String, dynamic> args) {
  return GameCoinRechargeRecordState()..isShowHead = false;
}
