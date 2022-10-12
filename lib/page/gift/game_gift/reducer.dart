import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameGiftState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameGiftState>>{
      GameGiftAction.action: _onAction,
    },
  );
}

GameGiftState _onAction(GameGiftState state, Action action) {
  final GameGiftState newState = state.clone();
  return newState;
}
