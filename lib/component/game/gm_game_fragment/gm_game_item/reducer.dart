import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GmGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GmGameItemState>>{
      GmGameItemAction.action: _onAction,
    },
  );
}

GmGameItemState _onAction(GmGameItemState state, Action action) {
  final GmGameItemState newState = state.clone();
  return newState;
}
