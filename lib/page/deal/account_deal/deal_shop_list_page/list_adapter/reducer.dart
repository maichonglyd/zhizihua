import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<DealShopListPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealShopListPageState>>{
      DealListAction.action: _onAction,
    },
  );
}

DealShopListPageState _onAction(DealShopListPageState state, Action action) {
  final DealShopListPageState newState = state.clone();
  return newState;
}
