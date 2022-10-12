import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealBuyRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealBuyRecordState>>{
      PropDealBuyRecordAction.action: _onAction,
      PropDealBuyRecordAction.updateOrders: _updateOrders,
    },
  );
}

PropDealBuyRecordState _onAction(PropDealBuyRecordState state, Action action) {
  final PropDealBuyRecordState newState = state.clone();
  return newState;
}

PropDealBuyRecordState _updateOrders(
    PropDealBuyRecordState state, Action action) {
  final PropDealBuyRecordState newState = state.clone();
  newState.orders = action.payload;
  return newState;
}
