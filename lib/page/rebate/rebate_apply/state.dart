import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';

class RebateApplyState implements Cloneable<RebateApplyState> {
  List<RebateGame> rebateGames;
  RefreshHelper refreshHelper = new RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  RebateApplyState clone() {
    return RebateApplyState()
      ..rebateGames = rebateGames
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

RebateApplyState initState(Map<String, dynamic> args) {
  return RebateApplyState()..rebateGames = List();
}
