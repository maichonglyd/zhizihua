import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealSellRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealSellRecordState>>{
      PropDealSellRecordAction.action: _onAction,
      PropDealSellRecordAction.updateSellRecord: _updateSellRecord,
    },
  );
}

PropDealSellRecordState _onAction(
    PropDealSellRecordState state, Action action) {
  final PropDealSellRecordState newState = state.clone();
  return newState;
}

PropDealSellRecordState _updateSellRecord(
    PropDealSellRecordState state, Action action) {
  final PropDealSellRecordState newState = state.clone();
  newState.goodsList = action.payload;
  return newState;
}
