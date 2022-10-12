import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RewardDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<RewardDetailState>>{
      RewardDetailAction.action: _onAction,
      RewardDetailAction.updateData: _updateData,
    },
  );
}

RewardDetailState _onAction(RewardDetailState state, Action action) {
  final RewardDetailState newState = state.clone();
  return newState;
}

RewardDetailState _updateData(RewardDetailState state, Action action) {
  final RewardDetailState newState = state.clone();
  newState.reward = action.payload;
  return newState;
}
