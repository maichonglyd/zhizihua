import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TaskCenterState> buildReducer() {
  return asReducer(
    <Object, Reducer<TaskCenterState>>{
      TaskCenterAction.action: _onAction,
      TaskCenterAction.updateData: _updateData,
      TaskCenterAction.updateUserInfo: _updateUserInfo,
      TaskCenterAction.updateTabs: _updateTabs,
    },
  );
}

TaskCenterState _updateTabs(TaskCenterState state, Action action) {
  final TaskCenterState newState = state.clone();
  print("_updateTabs${action.payload.toString()}");
  newState.tabs = action.payload;
  return newState;
}

TaskCenterState _onAction(TaskCenterState state, Action action) {
  final TaskCenterState newState = state.clone();
  return newState;
}

TaskCenterState _updateData(TaskCenterState state, Action action) {
  final TaskCenterState newState = state.clone();
  newState.taskHome = action.payload;
  return newState;
}

TaskCenterState _updateUserInfo(TaskCenterState state, Action action) {
  final TaskCenterState newState = state.clone();
  newState.userInfo = action.payload;

  return newState;
}
