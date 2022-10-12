import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ActivityListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ActivityListState>>{
      ActivityListAction.action: _onAction,
      ActivityListAction.updateData: _updateData,
    },
  );
}

ActivityListState _onAction(ActivityListState state, Action action) {
  final ActivityListState newState = state.clone();
  return newState;
}

ActivityListState _updateData(ActivityListState state, Action action) {
  final ActivityListState newState = state.clone();
  newState.dataList = action.payload;
  return newState;
}
