import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/deal/deal_config.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexDealFragmentState>>{
      IndexDealFragmentAction.action: _onAction,
      IndexDealFragmentAction.updateDealIndex: _upDateDealIndex,
      IndexDealFragmentAction.updateDealGoods: _updateDealGoods,
    },
  );
}

IndexDealFragmentState _onAction(IndexDealFragmentState state, Action action) {
  final IndexDealFragmentState newState = state.clone();
  return newState;
}

IndexDealFragmentState _upDateDealIndex(
    IndexDealFragmentState state, Action action) {
  final IndexDealFragmentState newState = state.clone();
  newState.dealIndexData = action.payload;
  print("dealIndexData: ${newState.dealIndexData.data.toString()}");
  if (newState.dealIndexData != null && newState.dealIndexData.data != null) {
    DealConfig.saveValue(
        DealConfig.SP_KEY_FEE_RATE, newState.dealIndexData.data.feeRate);
    DealConfig.saveValue(
        DealConfig.SP_KEY_MIN_FEE, newState.dealIndexData.data.minFee);
    DealConfig.saveValue(
        DealConfig.SP_KEY_MIN_PRICE, newState.dealIndexData.data.minPrice);
  }
  return newState;
}

IndexDealFragmentState _updateDealGoods(
    IndexDealFragmentState state, Action action) {
  final IndexDealFragmentState newState = state.clone();
  newState.dealGoods = action.payload;
  return newState;
}
