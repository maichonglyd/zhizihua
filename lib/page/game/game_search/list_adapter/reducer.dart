import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<GameSearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameSearchState>>{
      ListAdapterAction.action: _onAction,
    },
  );
}

GameSearchState _onAction(GameSearchState state, Action action) {
  final GameSearchState newState = state.clone();
  return newState;
}
