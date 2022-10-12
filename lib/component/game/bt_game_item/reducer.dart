import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BTGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<BTGameItemState>>{
      BTGameItemAction.action: _onAction,
    },
  );
}

BTGameItemState _onAction(BTGameItemState state, Action action) {
  final BTGameItemState newState = state.clone();
  return newState;
}
