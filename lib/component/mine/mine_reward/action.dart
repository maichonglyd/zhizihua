import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/coupon_my_reward_data.dart';

//TODO replace with your own action
enum MineRewardAction { action, getData, updateData, getReward }

class MineRewardActionCreator {
  static Action onAction() {
    return const Action(MineRewardAction.action);
  }

  static Action getData(int page) {
    return Action(MineRewardAction.getData, payload: page);
  }

  static Action updateData(List<CouponData> dataList) {
    return Action(MineRewardAction.updateData, payload: dataList);
  }

  static Action getReward(CouponData data) {
    return Action(MineRewardAction.getReward, payload: data);
  }
}
