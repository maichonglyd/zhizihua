import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountRecyclePaybackState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecyclePaybackState>>{
      AccountRecyclePaybackAction.action: _onAction,
      AccountRecyclePaybackAction.switchPay: _switchPay,
    },
  );
}

AccountRecyclePaybackState _onAction(
    AccountRecyclePaybackState state, Action action) {
  final AccountRecyclePaybackState newState = state.clone();
  return newState;
}

AccountRecyclePaybackState _switchPay(
    AccountRecyclePaybackState state, Action action) {
  final AccountRecyclePaybackState newState = state.clone();
  newState.payIndex = action.payload;
  return newState;
}
