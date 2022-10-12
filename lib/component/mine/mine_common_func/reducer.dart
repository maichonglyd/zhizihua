import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineCommonFuncState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineCommonFuncState>>{
      MineCommonFuncAction.action: _onAction,
    },
  );
}

MineCommonFuncState _onAction(MineCommonFuncState state, Action action) {
  final MineCommonFuncState newState = state.clone();
  return newState;
}
