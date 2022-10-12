import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ActivityNewsState> buildReducer() {
  return asReducer(
    <Object, Reducer<ActivityNewsState>>{
      ActivityNewsAction.action: _onAction,
    },
  );
}

ActivityNewsState _onAction(ActivityNewsState state, Action action) {
  final ActivityNewsState newState = state.clone();
  return newState;
}
