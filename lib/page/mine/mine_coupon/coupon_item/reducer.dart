import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CouponItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<CouponItemState>>{
      BTGameItemAction.action: _onAction,
    },
  );
}

CouponItemState _onAction(CouponItemState state, Action action) {
  final CouponItemState newState = state.clone();
  return newState;
}
