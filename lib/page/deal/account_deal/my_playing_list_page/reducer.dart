import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlayingListState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlayingListState>>{
      PlayingListAction.action: _onAction,
      PlayingListAction.updatePlayedGames: _updatePlayedGames,
    },
  );
}

PlayingListState _onAction(PlayingListState state, Action action) {
  final PlayingListState newState = state.clone();
  return newState;
}

PlayingListState _updatePlayedGames(PlayingListState state, Action action) {
  final PlayingListState newState = state.clone();
  newState.playedGames = action.payload;
  return newState;
}
