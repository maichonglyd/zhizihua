import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealOrderDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealOrderDetailsState>>{
      PropDealOrderDetailsAction.action: _onAction,
      PropDealOrderDetailsAction.updateOrderDetails: _updateOrderDetails,
    },
  );
}

PropDealOrderDetailsState _onAction(
    PropDealOrderDetailsState state, Action action) {
  final PropDealOrderDetailsState newState = state.clone();
  return newState;
}

PropDealOrderDetailsState _updateOrderDetails(
    PropDealOrderDetailsState state, Action action) {
  final PropDealOrderDetailsState newState = state.clone();
  newState.dealPropOrderDetailsData = action.payload;
  newState.loadStatus = LoadStatus.success;
  return newState;
}
