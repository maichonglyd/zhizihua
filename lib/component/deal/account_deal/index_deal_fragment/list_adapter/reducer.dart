import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<IndexDealFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexDealFragmentState>>{
      IndexDealAction.action: _onAction,
    },
  );
}

IndexDealFragmentState _onAction(IndexDealFragmentState state, Action action) {
  final IndexDealFragmentState newState = state.clone();
  return newState;
}
