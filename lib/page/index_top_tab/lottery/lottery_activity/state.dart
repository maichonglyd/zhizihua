import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_activity_info.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_reward_list.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_start_model.dart';
import 'package:flutter_huoshu_app/widget/LotteryMachineView.dart';

class LotteryActivityState implements Cloneable<LotteryActivityState> {
  LotteryMachineController controller = LotteryMachineController();
  List<LotteryRewardBean> rewardList = [];
  LotteryActivityInfo info;
  List<LotteryMyRewardBean> myRewardList = [];
  bool startLottery = false;
  LotteryMyRewardBean userReward;

  @override
  LotteryActivityState clone() {
    return LotteryActivityState()
      ..controller = controller
      ..rewardList = rewardList
      ..info = info
      ..myRewardList = myRewardList
      ..startLottery = startLottery
      ..userReward = userReward;
  }
}

LotteryActivityState initState(Map<String, dynamic> args) {
  return LotteryActivityState();
}
