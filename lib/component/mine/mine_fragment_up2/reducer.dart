import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineFragmentState>>{
      MineFragmentAction.action: _onAction,
      MineFragmentAction.updateUserInfo: _updateUserInfo,
      MineFragmentAction.updateMsgCount: _updateMsgCount,
      MineFragmentAction.updateExpand: _updateExpand,
      MineFragmentAction.createController: _createController,
    },
  );
}

MineFragmentState _createController(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  newState.scrollController = action.payload['scrollController'];
  return newState;
}

MineFragmentState _updateExpand(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
  newState.isExpand = action.payload;
  return newState;
}

MineFragmentState _onAction(MineFragmentState state, Action action) {
  final MineFragmentState newState = state.clone();
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
