import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCoinRechargeRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCoinRechargeRecordState>>{
      GameCoinRechargeRecordAction.action: _onAction,
      GameCoinRechargeRecordAction.switchHead: _switchHead,
      GameCoinRechargeRecordAction.updateRecords: _updateRecords,
    },
  );
}

GameCoinRechargeRecordState _onAction(
    GameCoinRechargeRecordState state, Action action) {
  final GameCoinRechargeRecordState newState = state.clone();
  return newState;
}

GameCoinRechargeRecordState _switchHead(
    GameCoinRechargeRecordState state, Action action) {
  final GameCoinRechargeRecordState newState = state.clone();
  newState.isShowHead = !state.isShowHead;
  return newState;
}

GameCoinRechargeRecordState _updateRecords(
    GameCoinRechargeRecordState state, Action action) {
  final GameCoinRechargeRecordState newState = state.clone();
  newState.records = action.payload;
  return newState;
}
