import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';

import 'action.dart';

Reducer<GameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameListState>>{
      GameListAdapterAction.action: _onAction,
    },
  );
}

GameListState _onAction(GameListState state, Action action) {
  final GameListState newState = state.clone();
  return newState;
}
