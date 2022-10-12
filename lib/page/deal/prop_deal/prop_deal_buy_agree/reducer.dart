import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealBuyAgreeState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealBuyAgreeState>>{
      PropDealBuyAgreeAction.action: _onAction,
    },
  );
}

PropDealBuyAgreeState _onAction(PropDealBuyAgreeState state, Action action) {
  final PropDealBuyAgreeState newState = state.clone();
  return newState;
}
