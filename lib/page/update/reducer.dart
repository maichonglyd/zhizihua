import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UpdatePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<UpdatePageState>>{
      UpdatePageAction.updateStatus: _updateStatus,
    },
  );
}

UpdatePageState _updateStatus(UpdatePageState state, Action action) {
  final UpdatePageState newState = state.clone();
  newState.status = action.payload['status'];
  newState.curProgress = action.payload['curProgress'];
  return newState;
}
