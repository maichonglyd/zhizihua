import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealDetailsState>>{
      PropDealDetailsAction.action: _onAction,
      PropDealDetailsAction.updateData: _updateData,
    },
  );
}

PropDealDetailsState _onAction(PropDealDetailsState state, Action action) {
  final PropDealDetailsState newState = state.clone();
  return newState;
}

PropDealDetailsState _updateData(PropDealDetailsState state, Action action) {
  final PropDealDetailsState newState = state.clone();
  newState.goods = action.payload;
  newState.loadStatus = LoadStatus.success;
  return newState;
}
