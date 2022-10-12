import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<JPGameItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<JPGameItemState>>{
      JPTopItemAction.action: _onAction,
    },
  );
}

JPGameItemState _onAction(JPGameItemState state, Action action) {
  final JPGameItemState newState = state.clone();
  return newState;
}
