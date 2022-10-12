import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountRecycleRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecycleRecordState>>{
      AccountRecycleRecordAction.action: _onAction,
      AccountRecycleRecordAction.update: _update,
      AccountRecycleRecordAction.updateExplain: _updateExplain,
    },
  );
}

AccountRecycleRecordState _onAction(
    AccountRecycleRecordState state, Action action) {
  final AccountRecycleRecordState newState = state.clone();
  return newState;
}

AccountRecycleRecordState _updateExplain(
    AccountRecycleRecordState state, Action action) {
  final AccountRecycleRecordState newState = state.clone();
  newState.recycleExplain = action.payload;
  return newState;
}

AccountRecycleRecordState _update(
    AccountRecycleRecordState state, Action action) {
  final AccountRecycleRecordState newState = state.clone();
  newState.recycleList = action.payload;
  return newState;
}
