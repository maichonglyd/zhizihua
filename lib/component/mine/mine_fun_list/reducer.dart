import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MineFunListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MineFunListState>>{
      MineFunListAction.action: _onAction,
    },
  );
}

MineFunListState _onAction(MineFunListState state, Action action) {
  final MineFunListState newState = state.clone();
  return newState;
}
