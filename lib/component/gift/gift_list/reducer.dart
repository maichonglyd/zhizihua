import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GiftListFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GiftListFragmentState>>{
      GiftListFragmentAction.action: _onAction,
      GiftListFragmentAction.updateData: _updateData,
    },
  );
}

GiftListFragmentState _onAction(GiftListFragmentState state, Action action) {
  final GiftListFragmentState newState = state.clone();
  return newState;
}

GiftListFragmentState _updateData(GiftListFragmentState state, Action action) {
  final GiftListFragmentState newState = state.clone();
  newState.gifts = action.payload;
  return newState;
}
