import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealHeadState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealHeadState>>{
      PropDealHeadAction.action: _onAction,
      LoginAction.logout: _logout,
    },
  );
}

PropDealHeadState _onAction(PropDealHeadState state, Action action) {
  final PropDealHeadState newState = state.clone();
  return newState;
}

PropDealHeadState _logout(PropDealHeadState state, Action action) {
  final PropDealHeadState newState = state.clone();
  return newState;
}
