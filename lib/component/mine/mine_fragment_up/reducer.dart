import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineFragmentState>>{
      MineFragmentAction.action: _onAction,
      MineFragmentAction.updateUserInfo: _updateUserInfo,
      MineFragmentAction.updateMemberData: _updateMemberData,
      MineFragmentAction.updateMsgCount: _updateMsgCount,
    },
  );
}

MineFragmentState _onAction(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  return newState;
}

MineFragmentState _updateMemberData(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  newState.memInfoData = action.payload;
  return newState;
}

MineFragmentState _updateUserInfo(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  newState.userInfo = (action.payload as UserInfo).data;
  return newState;
}

MineFragmentState _updateMsgCount(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  newState.msgCount = action.payload;
  return newState;
}
