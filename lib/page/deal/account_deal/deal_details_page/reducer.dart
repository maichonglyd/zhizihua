import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealDetailsState>>{
      DealDetailsAction.action: _onAction,
      DealDetailsAction.updateDetails: _updateDetails,
      DealDetailsAction.updatePayInfoData: _updatePayInfoData,
    },
  );
}

DealDetailsState _updatePayInfoData(DealDetailsState state, Action action) {
  final DealDetailsState newState = state.clone();
  newState.dealPayInfoData = action.payload;
  return newState;
}

DealDetailsState _onAction(DealDetailsState state, Action action) {
  final DealDetailsState newState = state.clone();
  return newState;
}

DealDetailsState _updateDetails(DealDetailsState state, Action action) {
  final DealDetailsState newState = state.clone();
  newState.dealGoods = action.payload;
  return newState;
}
