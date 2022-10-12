import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameNewNoticeState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameNewNoticeState>>{
      GameNewNoticeAction.action: _onAction,
    },
  );
}

GameNewNoticeState _onAction(GameNewNoticeState state, Action action) {
  final GameNewNoticeState newState = state.clone();
  return newState;
}
