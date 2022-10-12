import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';

import 'action.dart';
import 'state.dart';

Reducer<VipOpenState> buildReducer() {
  return asReducer(
    <Object, Reducer<VipOpenState>>{
      VipOpenAction.action: _onAction,
      VipOpenAction.updateVipList: _updateVipList,
      VipOpenAction.updateMemberData: _updateMemberData,
      VipOpenAction.updatePayInfoData: _updatePayInfoData,
      VipOpenAction.updateRecordList: _updateRecordList,
    },
  );
}

VipOpenState _updateRecordList(VipOpenState state, Action action) {
  final VipOpenState newState = state.clone();
  List<RecordMod> recordList = List();
  newState.recordList = action.payload;
//  recordList.clear();
//  for (int i = 0; i < 7; i++) {
//    recordList.add(newState.recordList[0]);
//  }
//  newState.recordList = recordList;
  return newState;
}

VipOpenState _updatePayInfoData(VipOpenState state, Action action) {
  final VipOpenState newState = state.clone();
  newState.vipPayInfoData = action.payload;
  return newState;
}

VipOpenState _updateMemberData(VipOpenState state, Action action) {
  final VipOpenState newState = state.clone();
  newState.memInfoData = action.payload;
  return newState;
}

VipOpenState _updateVipList(VipOpenState state, Action action) {
  final VipOpenState newState = state.clone();
  newState.payWayMods = action.payload["PayWayModList"];
  newState.vipMods = action.payload["VIPModList"];
  return newState;
}

VipOpenState _onAction(VipOpenState state, Action action) {
  final VipOpenState newState = state.clone();
  return newState;
}
