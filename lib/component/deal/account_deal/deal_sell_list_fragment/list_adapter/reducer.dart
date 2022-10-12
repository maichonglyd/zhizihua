import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<DealSellListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSellListState>>{
      DealSellListAction.action: _onAction,
    },
  );
}

DealSellListState _onAction(DealSellListState state, Action action) {
  final DealSellListState newState = state.clone();
  return newState;
}
