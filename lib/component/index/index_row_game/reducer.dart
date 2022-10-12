import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexRowGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexRowGameState>>{
      IndexRowGameAction.action: _onAction,
    },
  );
}

IndexRowGameState _onAction(IndexRowGameState state, Action action) {
  final IndexRowGameState newState = state.clone();
  return newState;
}
