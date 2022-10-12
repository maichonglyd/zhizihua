import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealSellListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealSellListState>>{
      DealSellListAction.action: _onAction,
      DealSellListAction.update: _update,
    },
  );
}

DealSellListState _onAction(DealSellListState state, Action action) {
  final DealSellListState newState = state.clone();
  return newState;
}

DealSellListState _update(DealSellListState state, Action action) {
  if (state.type == action.payload['type']) {
    final DealSellListState newState = state.clone();
    newState.dealGoodsList = action.payload['list'];
    return newState;
  }
//  不是自己的类型不做处理
  return state;
}
