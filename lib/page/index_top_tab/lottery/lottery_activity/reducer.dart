import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LotteryActivityState> buildReducer() {
  return asReducer(
    <Object, Reducer<LotteryActivityState>>{
      LotteryActivityAction.action: _onAction,
      LotteryActivityAction.updateRewardList: _updateRewardList,
      LotteryActivityAction.updateInfo: _updateInfo,
      LotteryActivityAction.updateMyReward: _updateMyReward,
    },
  );
}

LotteryActivityState _onAction(LotteryActivityState state, Action action) {
  final LotteryActivityState newState = state.clone();
  return newState;
}

LotteryActivityState _updateRewardList(
    LotteryActivityState state, Action action) {
  final LotteryActivityState newState = state.clone();
  newState.rewardList = action.payload;
  return newState;
}

LotteryActivityState _updateInfo(LotteryActivityState state, Action action) {
  final LotteryActivityState newState = state.clone();
  newState.info = action.payload;
  return newState;
}

LotteryActivityState _updateMyReward(
    LotteryActivityState state, Action action) {
  final LotteryActivityState newState = state.clone();
  newState.myRewardList = action.payload;
  return newState;
}
