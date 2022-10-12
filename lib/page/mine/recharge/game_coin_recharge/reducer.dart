import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCoinRechargeState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCoinRechargeState>>{
      GameCoinRechargeAction.action: _onAction,
      GameCoinRechargeAction.changePayType: _changePayType,
      GameCoinRechargeAction.updateAmount: _updateAmount,
      GameCoinRechargeAction.updateGame: _updateGame,
      GameCoinRechargeAction.addPic: _addPic,
      GameCoinRechargeAction.deletePic: _deletePic,
      GameCoinRechargeAction.updateRate: _updateRate,
    },
  );
}

GameCoinRechargeState _addPic(GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.images.add(ImageUploadData.withFile(file: action.payload));
  return newState;
}

GameCoinRechargeState _deletePic(GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.images.removeAt(action.payload);
  return newState;
}

GameCoinRechargeState _onAction(GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  return newState;
}

GameCoinRechargeState _updateGame(GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.game = action.payload;
  return newState;
}

GameCoinRechargeState _updateAmount(
    GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.amount = action.payload;
  return newState;
}

GameCoinRechargeState _changePayType(
    GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.payType = action.payload;
  return newState;
}

GameCoinRechargeState _updateRate(GameCoinRechargeState state, Action action) {
  final GameCoinRechargeState newState = state.clone();
  newState.rate = action.payload;
  return newState;
}
