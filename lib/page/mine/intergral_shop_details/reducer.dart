import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

import 'action.dart';
import 'state.dart';

Reducer<IntegralShopDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<IntegralShopDetailsState>>{
      IntegralShopDetailsAction.action: _onAction,
      IntegralShopDetailsAction.update: _update,
      IntegralShopDetailsAction.err: _err,
    },
  );
}

IntegralShopDetailsState _onAction(
    IntegralShopDetailsState state, Action action) {
  final IntegralShopDetailsState newState = state.clone();
  return newState;
}

IntegralShopDetailsState _err(IntegralShopDetailsState state, Action action) {
  final IntegralShopDetailsState newState = state.clone();
  newState.loadStatus = LoadStatus.error;
  return newState;
}

IntegralShopDetailsState _update(
    IntegralShopDetailsState state, Action action) {
  final IntegralShopDetailsState newState = state.clone();
  newState.goodsDetails = action.payload;

//  if (newState.goodsDetails != null &&
//      newState.goodsDetails.gift.giftCode != null &&
//      newState.goodsDetails.gift.giftCode.isNotEmpty) {
//    newState.buttonText = "复制";
//  }
  newState.loadStatus = LoadStatus.success;
  return newState;
}
