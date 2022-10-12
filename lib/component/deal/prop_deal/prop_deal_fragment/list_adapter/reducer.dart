import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<PropDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealFragmentState>>{
      PropDealListAdapterAction.action: _onAction,
    },
  );
}

PropDealFragmentState _onAction(PropDealFragmentState state, Action action) {
  final PropDealFragmentState newState = state.clone();
  return newState;
}
