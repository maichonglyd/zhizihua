import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RebateRecordListState> buildReducer() {
  return asReducer(
    <Object, Reducer<RebateRecordListState>>{
      RebateRecordListAction.action: _onAction,
      RebateRecordListAction.updateRecords: _updateRecords,
    },
  );
}

RebateRecordListState _onAction(RebateRecordListState state, Action action) {
  final RebateRecordListState newState = state.clone();
  return newState;
}

RebateRecordListState _updateRecords(
    RebateRecordListState state, Action action) {
  final RebateRecordListState newState = state.clone();
  newState.records = action.payload;
  return newState;
}
