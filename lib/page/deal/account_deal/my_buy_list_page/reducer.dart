import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyBuyListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyBuyListState>>{
      MyBuyListAction.action: _onAction,
      MyBuyListAction.update: _update,
    },
  );
}

MyBuyListState _onAction(MyBuyListState state, Action action) {
  final MyBuyListState newState = state.clone();
  return newState;
}

MyBuyListState _update(MyBuyListState state, Action action) {
  final MyBuyListState newState = state.clone();
  newState.orders = action.payload;
  return newState;
}
