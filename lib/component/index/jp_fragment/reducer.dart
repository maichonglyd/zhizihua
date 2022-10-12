import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'action.dart';
import 'state.dart';

Reducer<JpFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<JpFragmentState>>{
      JpFragmentAction.action: _onAction,
      JpFragmentAction.update: _update,
    },
  );
}

JpFragmentState _onAction(JpFragmentState state, Action action) {
  final JpFragmentState newState = state.clone();
  return newState;
}

JpFragmentState _update(JpFragmentState state, Action action) {
  final JpFragmentState newState = state.clone();
  List<Game> data = action.payload;
  newState.jpGameStates =
      data.map((game) => JPGameItemState()..game = game).toList();
  return newState;
}
