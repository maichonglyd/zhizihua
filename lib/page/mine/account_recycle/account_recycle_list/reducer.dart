import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/action.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/state.dart';

Reducer<AccountRecycleState> buildReducer() {
  return asReducer(
    <Object, Reducer<AccountRecycleState>>{
      AccountRecycleAction.action: _onAction,
      AccountRecycleAction.updateExplain: _updateExplain,
      AccountRecycleAction.updateRecycleList: _updateRecycleList,
    },
  );
}

AccountRecycleState _onAction(AccountRecycleState state, Action action) {
  final AccountRecycleState newState = state.clone();
  return newState;
}

AccountRecycleState _updateExplain(AccountRecycleState state, Action action) {
  final AccountRecycleState newState = state.clone();
  newState.explain = action.payload;
  return newState;
}

AccountRecycleState _updateRecycleList(
    AccountRecycleState state, Action action) {
  final AccountRecycleState newState = state.clone();
  newState.recycleGames = action.payload;
  return newState;
}
