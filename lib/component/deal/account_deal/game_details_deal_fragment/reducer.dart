import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailsDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsDealFragmentState>>{
      GameDetailsDealFragmentAction.action: _onAction,
      GameDetailsDealFragmentAction.update: _update,
    },
  );
}

GameDetailsDealFragmentState _onAction(
    GameDetailsDealFragmentState state, Action action) {
  final GameDetailsDealFragmentState newState = state.clone();
  return newState;
}

GameDetailsDealFragmentState _update(
    GameDetailsDealFragmentState state, Action action) {
  final GameDetailsDealFragmentState newState = state.clone();
  newState.dealGoods = action.payload;
  return newState;
}
