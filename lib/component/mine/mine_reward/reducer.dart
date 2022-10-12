import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineRewardState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineRewardState>>{
      MineRewardAction.action: _onAction,
      MineRewardAction.updateData: _updateData,
    },
  );
}

MineRewardState _onAction(MineRewardState state, Action action) {
  final MineRewardState newState = state.clone();
  return newState;
}

MineRewardState _updateData(MineRewardState state, Action action) {
  final MineRewardState newState = state.clone();
  newState.dataList = action.payload;
  return newState;
}
