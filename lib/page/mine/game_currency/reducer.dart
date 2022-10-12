import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCurrencyListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCurrencyListState>>{
      GameCurrencyListAction.action: _onAction,
      GameCurrencyListAction.updateGameCurrencyList: _updateGameCurrencyList
    },
  );
}

GameCurrencyListState _updateGameCurrencyList(
    GameCurrencyListState state, Action action) {
  final GameCurrencyListState newState = state.clone();
  newState.games = action.payload;
  return newState;
}

GameCurrencyListState _onAction(GameCurrencyListState state, Action action) {
  final GameCurrencyListState newState = state.clone();
  return newState;
}
