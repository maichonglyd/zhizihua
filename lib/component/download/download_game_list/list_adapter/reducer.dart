import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<DownLoadGameListState> buildReducer() {
  return asReducer(
    <Object, Reducer<DownLoadGameListState>>{
      DownloadGameListAction.action: _onAction,
    },
  );
}

DownLoadGameListState _onAction(DownLoadGameListState state, Action action) {
  final DownLoadGameListState newState = state.clone();
  return newState;
}
