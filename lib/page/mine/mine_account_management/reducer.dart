import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<AccountManageState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountManageState>>{
      AccountManageAction.action: _onAction,
      AccountManageAction.updateUserInfo: _updateUserInfo,
    },
  );
}

AccountManageState _onAction(AccountManageState state, Action action) {
  final AccountManageState newState = state.clone();
  return newState;
}

AccountManageState _updateUserInfo(AccountManageState state, Action action) {
  final AccountManageState newState = state.clone();
  newState.userInfo = (action.payload as UserInfo).data;
  newState.nicknameEditController.text = newState.userInfo.nickname;
  return newState;
}
