import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FriendRewardState> buildReducer() {
  return asReducer(
    <Object, Reducer<FriendRewardState>>{
      FriendRewardAction.action: _onAction,
      FriendRewardAction.updateData: _updateData,
    },
  );
}

FriendRewardState _onAction(FriendRewardState state, Action action) {
  final FriendRewardState newState = state.clone();
  return newState;
}

FriendRewardState _updateData(FriendRewardState state, Action action) {
  final FriendRewardState newState = state.clone();
  newState.dataList = action.payload;
  return newState;
}
