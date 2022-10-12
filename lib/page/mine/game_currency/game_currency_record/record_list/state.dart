import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_record_bean.dart';

class CurrRecordListState implements Cloneable<CurrRecordListState> {
  List<Game> games;
  List<String> testDatas = ["123", "456", "789"];
  List<GameRechargeBean> recordList;
  int status = 1; //1 充值 2 消费
  int gameId;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  CurrRecordListState clone() {
    return CurrRecordListState()
      ..testDatas = testDatas
      ..status = status
      ..gameId = gameId
      ..recordList = recordList
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

CurrRecordListState initState(int status, int gameId) {
  return CurrRecordListState()
    ..status = status
    ..gameId = gameId;
}
