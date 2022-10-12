import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralShopState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralShopState>>{
      IntegralShopAction.action: _onAction,
      IntegralShopAction.updateIntegral: _updateIntegral,
      IntegralShopAction.createController: _createController,
    },
  );
}

IntegralShopState _onAction(IntegralShopState state, Action action) {
  final IntegralShopState newState = state.clone();
  return newState;
}

IntegralShopState _updateIntegral(IntegralShopState state, Action action) {
  final IntegralShopState newState = state.clone();
  newState.integral = action.payload;
  return newState;
}

IntegralShopState _createController(IntegralShopState state, Action action) {
  final IntegralShopState newState = state.clone();
  newState.controller = action.payload;
  return newState;
}
