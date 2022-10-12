import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_details_fragment/state.dart';

import 'action.dart';

Reducer<GameDetailsComponentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsComponentState>>{
      GameDetailsAction.action: _onAction,
    },
  );
}

GameDetailsComponentState _onAction(
    GameDetailsComponentState state, Action action) {
  final GameDetailsComponentState newState = state.clone();
  return newState;
}
