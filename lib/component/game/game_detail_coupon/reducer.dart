import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameDetailCouponState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailCouponState>>{
      GameDetailCouponAction.action: _onAction,
    },
  );
}

GameDetailCouponState _onAction(GameDetailCouponState state, Action action) {
  final GameDetailCouponState newState = state.clone();
  return newState;
}
