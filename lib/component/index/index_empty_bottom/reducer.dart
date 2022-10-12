import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexEmptyBottomState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexEmptyBottomState>>{
      IndexEmptyBottomAction.action: _onAction,
    },
  );
}

IndexEmptyBottomState _onAction(IndexEmptyBottomState state, Action action) {
  final IndexEmptyBottomState newState = state.clone();
  return newState;
}
