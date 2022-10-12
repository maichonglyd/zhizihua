import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealShopListPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealShopListPageState>>{
      DealShopListPageAction.action: _onAction,
      DealShopListPageAction.update: _update,
    },
  );
}

DealShopListPageState _onAction(DealShopListPageState state, Action action) {
  final DealShopListPageState newState = state.clone();
  return newState;
}

DealShopListPageState _update(DealShopListPageState state, Action action) {
  final DealShopListPageState newState = state.clone();
  newState.dealGoodsList = action.payload;
  return newState;
}
