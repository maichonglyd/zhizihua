import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<JPGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<JPGameItemState>>{
      JPGameItemAction.action: _onAction,
    },
  );
}

JPGameItemState _onAction(JPGameItemState state, Action action) {
  final JPGameItemState newState = state.clone();
  return newState;
}
