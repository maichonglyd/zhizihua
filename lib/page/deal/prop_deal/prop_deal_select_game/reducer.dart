import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealSelectGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealSelectGameState>>{
      PropDealSelectGameAction.action: _onAction,
      PropDealSelectGameAction.updateGames: _updateGames,
    },
  );
}

PropDealSelectGameState _onAction(
    PropDealSelectGameState state, Action action) {
  final PropDealSelectGameState newState = state.clone();
  return newState;
}

PropDealSelectGameState _updateGames(
    PropDealSelectGameState state, Action action) {
  final PropDealSelectGameState newState = state.clone();
  newState.games = state.games;
  return newState;
}
