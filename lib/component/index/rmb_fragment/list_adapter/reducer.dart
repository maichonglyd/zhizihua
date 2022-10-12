import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import '../state.dart';

Reducer<RmbFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<RmbFragmentState>>{
      RmbListAction.action: _onAction,
    },
  );
}

RmbFragmentState _onAction(RmbFragmentState state, Action action) {
  final RmbFragmentState newState = state.clone();
  return newState;
}
