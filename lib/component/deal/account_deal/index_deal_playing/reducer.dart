import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealPlayingState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealPlayingState>>{
      DealPlayingAction.action: _onAction,
    },
  );
}

DealPlayingState _onAction(DealPlayingState state, Action action) {
  final DealPlayingState newState = state.clone();
  return newState;
}
