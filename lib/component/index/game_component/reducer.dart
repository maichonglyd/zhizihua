import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SingleGameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<SingleGameListState>>{
      SingleGameListAction.action: _onAction,
      SingleGameListAction.updateData: _updateData,
    },
  );
}

SingleGameListState _updateData(SingleGameListState state, Action action) {
  final SingleGameListState newState = state.clone();
  state.games = action.payload;
  return newState;
}

SingleGameListState _onAction(SingleGameListState state, Action action) {
  final SingleGameListState newState = state.clone();
  return newState;
}
