import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WebPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<WebPageState>>{
      WebPageAction.action: _onAction,
      WebPageAction.updateUserAgent: _updateUserAgent,
    },
  );
}

WebPageState _onAction(WebPageState state, Action action) {
  final WebPageState newState = state.clone();
  return newState;
}

WebPageState _updateUserAgent(WebPageState state, Action action) {
  final WebPageState newState = state.clone();
  newState.userAgent = action.payload;
  return newState;
}
