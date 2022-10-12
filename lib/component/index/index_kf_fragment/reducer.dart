import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<KfFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<KfFragmentState>>{
      KfFragmentAction.action: _onAction,
      KfFragmentAction.createController: _createController,
      KfFragmentAction.updateIndex: _updateIndex,
    },
  );
}

KfFragmentState _onAction(KfFragmentState state, Action action) {
  final KfFragmentState newState = state.clone();
  return newState;
}

KfFragmentState _updateIndex(KfFragmentState state, Action action) {
//  state.index = action.payload;
  final KfFragmentState newState = state.clone();
  newState.index = action.payload;
  print(newState.index);
  return newState;
}

KfFragmentState _createController(KfFragmentState state, Action action) {
  final KfFragmentState newState = state.clone();
  newState.tabController = action.payload;
  return newState;
}
