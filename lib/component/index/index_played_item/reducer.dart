import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexPlayedItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexPlayedItemState>>{
      IndexPlayedItemAction.action: _onAction,
    },
  );
}

IndexPlayedItemState _onAction(IndexPlayedItemState state, Action action) {
  final IndexPlayedItemState newState = state.clone();
  return newState;
}
