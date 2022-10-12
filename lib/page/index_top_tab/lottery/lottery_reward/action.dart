import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';

//TODO replace with your own action
enum LotteryRewardAction {
  action,
  getData,
  updateData,
  showAddressDialog,
}

class LotteryRewardActionCreator {
  static Action onAction() {
    return const Action(LotteryRewardAction.action);
  }

  static Action getData(int page) {
    return Action(LotteryRewardAction.getData, payload: page);
  }

  static Action updateData(List<LotteryMyRewardBean> bean) {
    return Action(LotteryRewardAction.updateData, payload: bean);
  }

  static Action showAddressDialog(String orderId) {
    return Action(LotteryRewardAction.showAddressDialog, payload: orderId);
  }
}
