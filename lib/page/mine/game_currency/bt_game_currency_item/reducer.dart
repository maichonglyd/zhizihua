import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCurrItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCurrItemState>>{
      BTGameItemAction.action: _onAction,
    },
  );
}

GameCurrItemState _onAction(GameCurrItemState state, Action action) {
  final GameCurrItemState newState = state.clone();
  return newState;
}
