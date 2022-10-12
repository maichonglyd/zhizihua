import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoadingDialogState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoadingDialogState>>{
//      LoadingDialogAction.loadOK: _loadOK,
    },
  );
}

LoadingDialogState _loadOK(LoadingDialogState state, Action action) {
  return state.clone()..loading=false;
}
