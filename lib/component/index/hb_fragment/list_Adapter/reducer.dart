import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import '../state.dart';

Reducer<HbFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<HbFragmentState>>{
      HbListAdapterAction.action: _onAction,
    },
  );
}

HbFragmentState _onAction(HbFragmentState state, Action action) {
  final HbFragmentState newState = state.clone();
  return newState;
}
