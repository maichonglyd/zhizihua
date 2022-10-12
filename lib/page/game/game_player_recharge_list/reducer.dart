import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GamePlayerRechargeListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GamePlayerRechargeListState>>{
      GamePlayerRechargeListAction.action: _onAction,
      GamePlayerRechargeListAction.updateData: _updateData,
    },
  );
}

GamePlayerRechargeListState _onAction(GamePlayerRechargeListState state, Action action) {
  final GamePlayerRechargeListState newState = state.clone();
  return newState;
}

GamePlayerRechargeListState _updateData(GamePlayerRechargeListState state, Action action) {
  final GamePlayerRechargeListState newState = state.clone();
  return newState;
}
