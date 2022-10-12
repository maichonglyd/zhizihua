import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<IntegralShopFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralShopFragmentState>>{
      IntegralShopListAction.action: _onAction,
    },
  );
}

IntegralShopFragmentState _onAction(
    IntegralShopFragmentState state, Action action) {
  final IntegralShopFragmentState newState = state.clone();
  return newState;
}
