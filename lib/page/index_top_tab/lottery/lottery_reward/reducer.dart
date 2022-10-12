import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LotteryRewardState> buildReducer() {
  return asReducer(
    <Object, Reducer<LotteryRewardState>>{
      LotteryRewardAction.action: _onAction,
      LotteryRewardAction.updateData: _updateData,
    },
  );
}

LotteryRewardState _onAction(LotteryRewardState state, Action action) {
  final LotteryRewardState newState = state.clone();
  return newState;
}

LotteryRewardState _updateData(LotteryRewardState state, Action action) {
  final LotteryRewardState newState = state.clone();
  newState.list = action.payload;
  return newState;
}
