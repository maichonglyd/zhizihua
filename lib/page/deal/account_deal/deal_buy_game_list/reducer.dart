import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealBuyGameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealBuyGameListState>>{
      DealBuyGameListAction.action: _onAction,
      DealBuyGameListAction.update: _update,
    },
  );
}

DealBuyGameListState _onAction(DealBuyGameListState state, Action action) {
  final DealBuyGameListState newState = state.clone();
  return newState;
}

DealBuyGameListState _update(DealBuyGameListState state, Action action) {
  final DealBuyGameListState newState = state.clone();
  newState.playedGames = action.payload;
  return newState;
}
