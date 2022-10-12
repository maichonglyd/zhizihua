import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PtzRechargeState> buildReducer() {
  return asReducer(
    <Object, Reducer<PtzRechargeState>>{
      PtzRechargeAction.action: _onAction,
      PtzRechargeAction.updatePrice: _updatePrice,
      PtzRechargeAction.updatePayType: _updatePayType,
      PtzRechargeAction.updatePayInfoData: _updatePayInfoData,
      PtzRechargeAction.updatePayWayList: _updatePayWayList,
    },
  );
}

PtzRechargeState _updatePayWayList(PtzRechargeState state, Action action) {
  final PtzRechargeState newState = state.clone();
  newState.payWayMods = action.payload["PayWayModList"];
  return newState;
}

PtzRechargeState _onAction(PtzRechargeState state, Action action) {
  final PtzRechargeState newState = state.clone();
  return newState;
}

PtzRechargeState _updatePrice(PtzRechargeState state, Action action) {
  final PtzRechargeState newState = state.clone();
  newState.money = action.payload;
  return newState;
}

PtzRechargeState _updatePayType(PtzRechargeState state, Action action) {
  final PtzRechargeState newState = state.clone();
  newState.payType = action.payload;
  return newState;
}

PtzRechargeState _updatePayInfoData(PtzRechargeState state, Action action) {
  final PtzRechargeState newState = state.clone();
  newState.dealPayInfoData = action.payload;
  return newState;
}
