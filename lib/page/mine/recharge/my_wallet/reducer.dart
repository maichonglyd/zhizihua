import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyWalletState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyWalletState>>{
      MyWalletAction.action: _onAction,
      MyWalletAction.updatePtbCnt: _updatePtbCnt,
    },
  );
}

MyWalletState _onAction(MyWalletState state, Action action) {
  final MyWalletState newState = state.clone();
  return newState;
}

MyWalletState _updatePtbCnt(MyWalletState state, Action action) {
  final MyWalletState newState = state.clone();
  newState.ptbCnt = (action.payload as UserInfo).data.ptbCnt;
  return newState;
}
