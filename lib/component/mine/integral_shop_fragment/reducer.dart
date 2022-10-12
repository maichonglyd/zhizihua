import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralShopFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralShopFragmentState>>{
      IntegralShopFragmentAction.action: _onAction,
      IntegralShopFragmentAction.updateGoods: _updateGoods,
    },
  );
}

IntegralShopFragmentState _onAction(
    IntegralShopFragmentState state, Action action) {
  final IntegralShopFragmentState newState = state.clone();
  return newState;
}

IntegralShopFragmentState _updateGoods(
    IntegralShopFragmentState state, Action action) {
  final IntegralShopFragmentState newState = state.clone();
  newState.goodsList = action.payload;
  return newState;
}
