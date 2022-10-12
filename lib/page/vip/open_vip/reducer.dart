import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OpenVipState> buildReducer() {
  return asReducer(
    <Object, Reducer<OpenVipState>>{
      OpenVipAction.action: _onAction,
      OpenVipAction.updatePayType: _updatePayType,
      OpenVipAction.updatePayInfoData: _updatePayInfoData,
      OpenVipAction.updateVipList: _updateVipList,
      OpenVipAction.updateVipId: _updateVipId,
    },
  );
}

OpenVipState _updateVipId(OpenVipState state, Action action) {
  final OpenVipState newState = state.clone();
  newState.selectedVipId = action.payload;
  return newState;
}

OpenVipState _updateVipList(OpenVipState state, Action action) {
  final OpenVipState newState = state.clone();
  newState.payWayMods = action.payload["PayWayModList"];
  newState.vipMods = action.payload["VIPModList"];
  return newState;
}

OpenVipState _onAction(OpenVipState state, Action action) {
  final OpenVipState newState = state.clone();
  return newState;
}

OpenVipState _updatePayType(OpenVipState state, Action action) {
  final OpenVipState newState = state.clone();
  newState.payType = action.payload;
  return newState;
}

OpenVipState _updatePayInfoData(OpenVipState state, Action action) {
  final OpenVipState newState = state.clone();
  newState.vipPayInfoData = action.payload;
  return newState;
}
