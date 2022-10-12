import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';

enum LoginAction {
  onLogin,
  gotoRegister,
  gotoFindPassword,
  loginOK,
  logout,
  updateLastLoginUser,
}

class LoginActionCreator {
  static Action onLogin() {
    return Action(LoginAction.onLogin, payload: null);
  }

  static Action gotoRegister() {
    return Action(LoginAction.gotoRegister, payload: null);
  }

  static Action gotoFindPassword() {
    return Action(LoginAction.gotoFindPassword, payload: null);
  }

  static Action loginOK() {
    return Action(LoginAction.loginOK, payload: null);
  }

  static Action logout() {
    return Action(LoginAction.logout, payload: null);
  }

  static Action updateLastLoginUser(UserInfo userInfo) {
    return Action(LoginAction.updateLastLoginUser, payload: userInfo);
  }
}
