import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexNewsState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexNewsState>>{
      IndexNewsAction.action: _onAction,
    },
  );
}

IndexNewsState _onAction(IndexNewsState state, Action action) {
  final IndexNewsState newState = state.clone();
  return newState;
}
