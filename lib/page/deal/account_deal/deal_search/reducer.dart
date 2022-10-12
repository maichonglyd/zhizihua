import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealSearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSearchState>>{
      GameSearchAction.action: _onAction,
      GameSearchAction.updateDealGoodsList: _updateGameList,
      GameSearchAction.updateHistory: _updateHistory,
    },
  );
}

DealSearchState _onAction(DealSearchState state, Action action) {
  final DealSearchState newState = state.clone();
  return newState;
}

DealSearchState _updateGameList(DealSearchState state, Action action) {
  final DealSearchState newState = state.clone();
  newState.dealGoods = action.payload;
  return newState;
}

DealSearchState _updateHistory(DealSearchState state, Action action) {
  final DealSearchState newState = state.clone();
  newState.dealHistoryList = action.payload;
  return newState;
}
