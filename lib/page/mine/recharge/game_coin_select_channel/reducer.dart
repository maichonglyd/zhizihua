import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCoinSelectChannelState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCoinSelectChannelState>>{
      GameCoinSelectChannelAction.action: _onAction,
    },
  );
}

GameCoinSelectChannelState _onAction(
    GameCoinSelectChannelState state, Action action) {
  final GameCoinSelectChannelState newState = state.clone();
  return newState;
}
