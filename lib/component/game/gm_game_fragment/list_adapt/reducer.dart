import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/state.dart';

import 'action.dart';

Reducer<GMGameFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GMGameFragmentState>>{
      GmGameAction.action: _onAction,
    },
  );
}

GMGameFragmentState _onAction(GMGameFragmentState state, Action action) {
  final GMGameFragmentState newState = state.clone();
  return newState;
}
