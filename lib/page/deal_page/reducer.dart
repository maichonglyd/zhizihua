import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealState>>{
      DealAction.action: _onAction,
    },
  );
}

DealState _onAction(DealState state, Action action) {
  final DealState newState = state.clone();
  return newState;
}
