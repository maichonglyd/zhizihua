import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralShopItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralShopItemState>>{
      IntegralShopItemAction.action: _onAction,
    },
  );
}

IntegralShopItemState _onAction(IntegralShopItemState state, Action action) {
  final IntegralShopItemState newState = state.clone();
  return newState;
}
