import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/repository/deal_history_repository.dart';

class DealSearchState implements Cloneable<DealSearchState> {
  TextEditingController contentController = TextEditingController();
  List<DealHistory> dealHistoryList;
  List<DealGoods> dealGoods;
  RefreshHelper refreshHelper;
  RefreshHelperController refreshHelperController;

  @override
  DealSearchState clone() {
    return DealSearchState()
      ..dealHistoryList = dealHistoryList
      ..contentController = contentController
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dealGoods = dealGoods;
  }
}

DealSearchState initState(Map<String, dynamic> args) {
  return DealSearchState()
    ..dealHistoryList = List()
    ..dealGoods = List()
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController();
}
