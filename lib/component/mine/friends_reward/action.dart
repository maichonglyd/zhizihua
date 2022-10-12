import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/coupon_friend_reward_data.dart';

//TODO replace with your own action
enum FriendRewardAction {
  action,
  getData,
  updateData,
}

class FriendRewardActionCreator {
  static Action onAction() {
    return const Action(FriendRewardAction.action);
  }

  static Action getData(int page) {
    return Action(FriendRewardAction.getData, payload: page);
  }

  static Action updateData(List<DataInfo> dataList) {
    return Action(FriendRewardAction.updateData, payload: dataList);
  }
}
