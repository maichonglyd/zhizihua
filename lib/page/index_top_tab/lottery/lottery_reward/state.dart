import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';

class LotteryRewardState implements Cloneable<LotteryRewardState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<LotteryMyRewardBean> list = [];

  @override
  LotteryRewardState clone() {
    return LotteryRewardState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..list = list;
  }
}

LotteryRewardState initState(Map<String, dynamic> args) {
  return LotteryRewardState();
}
