import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(<Object, Reducer<LoginState>>{
    LoginAction.updateLastLoginUser: _updateLastLoginUser,
  });
}

LoginState _updateLastLoginUser(LoginState state, Action action) {
  UserInfo userInfo = action.payload;
  LoginState newState = state.clone();
  newState.mobileController.text = userInfo.username;
  newState.passwordController.text = userInfo.password;
  return newState;
}
