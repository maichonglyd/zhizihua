import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DownloadGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<DownloadGameItemState>>{
      DownloadGameItemAction.action: _onAction,
    },
  );
}

DownloadGameItemState _onAction(DownloadGameItemState state, Action action) {
  final DownloadGameItemState newState = state.clone();
  return newState;
}
