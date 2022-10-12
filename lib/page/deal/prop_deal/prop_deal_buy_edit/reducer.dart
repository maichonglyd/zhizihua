import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealBuyState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealBuyState>>{
      PropDealBuyAction.action: _onAction,
    },
  );
}

PropDealBuyState _onAction(PropDealBuyState state, Action action) {
  final PropDealBuyState newState = state.clone();
  return newState;
}
