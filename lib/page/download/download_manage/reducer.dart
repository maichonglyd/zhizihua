import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DownLoadManageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DownLoadManageState>>{
      DownLoadManageAction.action: _onAction,
    },
  );
}

DownLoadManageState _onAction(DownLoadManageState state, Action action) {
  final DownLoadManageState newState = state.clone();
  return newState;
}
