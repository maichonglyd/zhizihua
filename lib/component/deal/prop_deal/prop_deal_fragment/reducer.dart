import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/deal/deal_config.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealFragmentState>>{
      PropDealFragmentAction.action: _onAction,
      PropDealFragmentAction.updateGoods: _updateGoods,
      PropDealFragmentAction.updateIndexData: _updateIndexData,
    },
  );
}

PropDealFragmentState _onAction(PropDealFragmentState state, Action action) {
  final PropDealFragmentState newState = state.clone();
  return newState;
}

PropDealFragmentState _updateIndexData(
    PropDealFragmentState state, Action action) {
  final PropDealFragmentState newState = state.clone();
  newState.dealPropIndexData = action.payload;

  if (newState.dealPropIndexData != null &&
      newState.dealPropIndexData.data != null) {
    DealConfig.saveValue(DealConfig.SP_KEY_PROP_FEE_RATE,
        newState.dealPropIndexData.data.feeRate);
    DealConfig.saveValue(
        DealConfig.SP_KEY_PROP_MIN_FEE, newState.dealPropIndexData.data.minFee);
    DealConfig.saveValue(DealConfig.SP_KEY_PROP_MIN_PRICE,
        newState.dealPropIndexData.data.minPrice);
  }
  return newState;
}

PropDealFragmentState _updateGoods(PropDealFragmentState state, Action action) {
  final PropDealFragmentState newState = state.clone();
  newState.goodsList = action.payload;
  return newState;
}
