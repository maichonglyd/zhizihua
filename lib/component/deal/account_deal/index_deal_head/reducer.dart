import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexDealHeadState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexDealHeadState>>{
      IndexDealHeadAction.action: _onAction,
      LoginAction.logout: _logout,
    },
  );
}

IndexDealHeadState _onAction(IndexDealHeadState state, Action action) {
  final IndexDealHeadState newState = state.clone();
  return newState;
}

IndexDealHeadState _logout(IndexDealHeadState state, Action action) {
  final IndexDealHeadState newState = state.clone();
  return newState;
}
