import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MySellListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MySellListState>>{
      MySellListAction.action: _onAction,
    },
  );
}

MySellListState _onAction(MySellListState state, Action action) {
  final MySellListState newState = state.clone();
  return newState;
}
