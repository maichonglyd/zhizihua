import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CurrRecordListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CurrRecordListState>>{
      CouponListAction.action: _onAction,
      CouponListAction.updateRecordList: _updateRecordList,
    },
  );
}

CurrRecordListState _onAction(CurrRecordListState state, Action action) {
  final CurrRecordListState newState = state.clone();
  return newState;
}

CurrRecordListState _updateRecordList(
    CurrRecordListState state, Action action) {
  final CurrRecordListState newState = state.clone();
  newState.recordList = action.payload;
  return newState;
}
