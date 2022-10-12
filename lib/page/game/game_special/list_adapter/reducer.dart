import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';

import '../state.dart';
import 'action.dart';

Reducer<GameSpecialPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSpecialPageState>>{
      GameListAdapterAction.action: _onAction,
    },
  );
}

GameSpecialPageState _onAction(GameSpecialPageState state, Action action) {
  final GameSpecialPageState newState = state.clone();
  return newState;
}
