import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';

//TODO replace with your own action
enum RewardDetailAction {
  action,
  getData,
  updateData,
}

class RewardDetailActionCreator {
  static Action onAction() {
    return const Action(RewardDetailAction.action);
  }

  static Action getData() {
    return const Action(RewardDetailAction.getData);
  }

  static Action updateData(LotteryMyRewardBean reward) {
    return Action(RewardDetailAction.updateData, payload: reward);
  }
}
