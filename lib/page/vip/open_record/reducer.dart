import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OpenRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<OpenRecordState>>{
      OpenRecordAction.action: _onAction,
      OpenRecordAction.updateRecordList: _updateRecordList
    },
  );
}

OpenRecordState _updateRecordList(OpenRecordState state, Action action) {
  final OpenRecordState newState = state.clone();
  newState.recordList = action.payload;
  return newState;
}

OpenRecordState _onAction(OpenRecordState state, Action action) {
  final OpenRecordState newState = state.clone();
  return newState;
}
