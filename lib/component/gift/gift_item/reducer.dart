import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GiftItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<GiftItemState>>{
      GiftItemAction.action: _onAction,
    },
  );
}

GiftItemState _onAction(GiftItemState state, Action action) {
  final GiftItemState newState = state.clone();
  return newState;
}
