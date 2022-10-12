import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexTopTabComponentState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexTopTabComponentState>>{
      IndexTopTabComponentAction.action: _onAction,
    },
  );
}

IndexTopTabComponentState _onAction(IndexTopTabComponentState state, Action action) {
  final IndexTopTabComponentState newState = state.clone();
  return newState;
}
