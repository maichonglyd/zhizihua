import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountRecycleCommitState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecycleCommitState>>{
      AccountRecycleCommitAction.action: _onAction,
    },
  );
}

AccountRecycleCommitState _onAction(
    AccountRecycleCommitState state, Action action) {
  final AccountRecycleCommitState newState = state.clone();
  return newState;
}
