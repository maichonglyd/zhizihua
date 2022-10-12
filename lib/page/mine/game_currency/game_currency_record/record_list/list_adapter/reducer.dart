import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<CurrRecordListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CurrRecordListState>>{
      CouponListAction.action: _onAction,
    },
  );
}

CurrRecordListState _onAction(CurrRecordListState state, Action action) {
  final CurrRecordListState newState = state.clone();
  return newState;
}
