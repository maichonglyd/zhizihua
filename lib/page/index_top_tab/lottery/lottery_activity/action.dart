import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_activity_info.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_reward_list.dart';

//TODO replace with your own action
enum LotteryActivityAction {
  action,
  buyLotteryChance,
  showRechargeDialog,
  getSelectReward,
  showRewardDialog,
  showAddressDialog,
  getData,
  updateRewardList,
  updateInfo,
  updateMyReward,
  buyChance,
  gotoInvitePage,
}

class LotteryActivityActionCreator {
  static Action onAction() {
    return const Action(LotteryActivityAction.action);
  }

  static Action buyLotteryChance(int num, String text) {
    return Action(LotteryActivityAction.buyLotteryChance, payload: {'num': num, 'text': text});
  }

  static Action showRechargeDialog() {
    return Action(LotteryActivityAction.showRechargeDialog);
  }

  static Action getSelectReward() {
    return const Action(LotteryActivityAction.getSelectReward);
  }

  static Action showRewardDialog() {
    return Action(LotteryActivityAction.showRewardDialog);
  }

  static Action showAddressDialog(String orderId) {
    return Action(LotteryActivityAction.showAddressDialog, payload: orderId);
  }

  static Action getData() {
    return const Action(LotteryActivityAction.getData);
  }

  static Action updateRewardList(List<LotteryRewardBean> list) {
    return Action(LotteryActivityAction.updateRewardList, payload: list);
  }

  static Action updateInfo(LotteryActivityInfo info) {
    return Action(LotteryActivityAction.updateInfo, payload: info);
  }

  static Action updateMyReward(List<LotteryMyRewardBean> list) {
    return Action(LotteryActivityAction.updateMyReward, payload: list);
  }

  static Action buyChance(num cnt) {
    return Action(LotteryActivityAction.buyChance, payload: cnt);
  }

  static Action gotoInvitePage() {
    return const Action(LotteryActivityAction.gotoInvitePage);
  }
}
