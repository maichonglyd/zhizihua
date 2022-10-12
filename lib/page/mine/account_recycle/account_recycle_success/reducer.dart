import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountRecycleSuccessState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecycleSuccessState>>{
      AccountRecycleSuccessAction.action: _onAction,
    },
  );
}

AccountRecycleSuccessState _onAction(
    AccountRecycleSuccessState state, Action action) {
  final AccountRecycleSuccessState newState = state.clone();
  return newState;
}
