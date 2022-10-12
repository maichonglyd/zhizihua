import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineCurrRecordState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineCurrRecordState>>{
      DownLoadManageAction.action: _onAction,
    },
  );
}

MineCurrRecordState _onAction(MineCurrRecordState state, Action action) {
  final MineCurrRecordState newState = state.clone();
  return newState;
}
