import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexTabTitleState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexTabTitleState>>{
      IndexTabTitleAction.action: _onAction,
      IndexTabTitleAction.createController: _createController,
    },
  );
}

IndexTabTitleState _onAction(IndexTabTitleState state, Action action) {
  final IndexTabTitleState newState = state.clone();
  return newState;
}

IndexTabTitleState _createController(IndexTabTitleState state, Action action) {
  final IndexTabTitleState newState = state.clone();
//  newState.tabController = action.payload;
  return newState;
}
