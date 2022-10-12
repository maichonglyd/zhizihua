import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DownLoadGameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DownLoadGameListState>>{
      DownLoadGameListAction.action: _onAction,
      DownLoadGameListAction.updateGameList: _updateGameList,
    },
  );
}

DownLoadGameListState _onAction(DownLoadGameListState state, Action action) {
  final DownLoadGameListState newState = state.clone();
  return newState;
}

DownLoadGameListState _updateGameList(
    DownLoadGameListState state, Action action) {
  final DownLoadGameListState newState = state.clone();
  newState.games = action.payload;
  return newState;
}
