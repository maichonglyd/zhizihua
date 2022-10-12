import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineTopTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineTopTabState>>{
      MineTopTabAction.action: _onAction,
    },
  );
}

MineTopTabState _onAction(MineTopTabState state, Action action) {
  final MineTopTabState newState = state.clone();
  return newState;
}
