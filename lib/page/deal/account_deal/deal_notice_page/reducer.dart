import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DealNoticeState> buildReducer() {
  return asReducer(
    <Object, Reducer<DealNoticeState>>{
      DealNoticeAction.action: _onAction,
    },
  );
}

DealNoticeState _onAction(DealNoticeState state, Action action) {
  final DealNoticeState newState = state.clone();
  return newState;
}
