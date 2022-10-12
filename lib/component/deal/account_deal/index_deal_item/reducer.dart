import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexDealItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexDealItemState>>{
      IndexDealItemAction.action: _onAction,
    },
  );
}

IndexDealItemState _onAction(IndexDealItemState state, Action action) {
  final IndexDealItemState newState = state.clone();
  return newState;
}
