import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemberCenterState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemberCenterState>>{
      MemberCenterAction.action: _onAction,
      MemberCenterAction.updateTabs: _updateTabs,
      MemberCenterAction.updateData: _updateData,
      MemberCenterAction.updateMemberData: _updateMemberData,
    },
  );
}

MemberCenterState _updateMemberData(MemberCenterState state, Action action) {
  final MemberCenterState newState = state.clone();
  newState.memInfoData = action.payload;
  return newState;
}

MemberCenterState _updateData(MemberCenterState state, Action action) {
  final MemberCenterState newState = state.clone();
  newState.taskHome = action.payload;
  return newState;
}

MemberCenterState _updateTabs(MemberCenterState state, Action action) {
  final MemberCenterState newState = state.clone();
  print("_updateTabs${action.payload.toString()}");
  newState.tabs = action.payload;
  return newState;
}

MemberCenterState _onAction(MemberCenterState state, Action action) {
  final MemberCenterState newState = state.clone();
  return newState;
}
