import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/cpl_mem_rank_list.dart';

class GamePlayerRechargeListState
    implements Cloneable<GamePlayerRechargeListState> {
  List<CplMemRank> rankList = [];
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  GamePlayerRechargeListState clone() {
    return GamePlayerRechargeListState()
      ..rankList = rankList
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController;
  }
}

GamePlayerRechargeListState initState(Map<String, dynamic> args) {
  return GamePlayerRechargeListState();
}
