import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RebateGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<RebateGameItemState>>{
      RebateGameItemAction.action: _onAction,
    },
  );
}

RebateGameItemState _onAction(RebateGameItemState state, Action action) {
  final RebateGameItemState newState = state.clone();
  return newState;
}
