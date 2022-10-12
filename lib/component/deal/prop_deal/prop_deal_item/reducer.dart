import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PropDealItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<PropDealItemState>>{
      PropDealItemAction.action: _onAction,
    },
  );
}

PropDealItemState _onAction(PropDealItemState state, Action action) {
  final PropDealItemState newState = state.clone();
  return newState;
}
