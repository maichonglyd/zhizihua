import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameCouponState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCouponState>>{
      GameCouponAction.action: _onAction,
      GameCouponAction.updateData: _updateData,
    },
  );
}

GameCouponState _onAction(GameCouponState state, Action action) {
  final GameCouponState newState = state.clone();
  return newState;
}

GameCouponState _updateData(GameCouponState state, Action action) {
  final GameCouponState newState = state.clone();
  newState.list = action.payload;
  return newState;
}