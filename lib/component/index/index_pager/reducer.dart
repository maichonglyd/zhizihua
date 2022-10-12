import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexViewPagerState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexViewPagerState>>{
      IndexViewPagerAction.action: _onAction,
    },
  );
}

IndexViewPagerState _onAction(IndexViewPagerState state, Action action) {
  final IndexViewPagerState newState = state.clone();
  return newState;
}
