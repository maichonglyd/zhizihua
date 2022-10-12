import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';

class RewardDetailState implements Cloneable<RewardDetailState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  String orderId;
  LotteryMyRewardBean reward;

  @override
  RewardDetailState clone() {
    return RewardDetailState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..orderId = orderId
      ..reward = reward;
  }
}

RewardDetailState initState(Map<String, dynamic> args) {
  return RewardDetailState()..orderId = args['orderId'];
}
