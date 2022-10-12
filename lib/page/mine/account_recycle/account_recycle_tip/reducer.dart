import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountRecycleTipState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecycleTipState>>{
      AccountRecycleTipAction.action: _onAction,
    },
  );
}

AccountRecycleTipState _onAction(AccountRecycleTipState state, Action action) {
  final AccountRecycleTipState newState = state.clone();
  return newState;
}
