import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameNewNoticeState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameNewNoticeState>>{
      GameNewNoticeAction.action: _onAction,
      GameNewNoticeAction.updateData: _updateData,
    },
  );
}

GameNewNoticeState _onAction(GameNewNoticeState state, Action action) {
  final GameNewNoticeState newState = state.clone();
  return newState;
}

GameNewNoticeState _updateData(GameNewNoticeState state, Action action) {
  final GameNewNoticeState newState = state.clone();
  newState.games = action.payload;
  return newState;
}
