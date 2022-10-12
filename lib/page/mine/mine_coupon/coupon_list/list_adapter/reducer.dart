import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<CouponListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CouponListState>>{
      CouponListAction.action: _onAction,
    },
  );
}

CouponListState _onAction(CouponListState state, Action action) {
  final CouponListState newState = state.clone();
  return newState;
}
