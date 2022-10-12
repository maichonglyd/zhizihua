import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineCouponState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineCouponState>>{
      DownLoadManageAction.action: _onAction,
    },
  );
}

MineCouponState _onAction(MineCouponState state, Action action) {
  final MineCouponState newState = state.clone();
  return newState;
}
