import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_kf_fragment/state.dart'
as kf_fragment;

import 'action.dart';
import 'state.dart';

Reducer<KaifuGameState> buildReducer() {
  return asReducer(
    <Object, Reducer<KaifuGameState>>{
      KaifuGameAction.action: _onAction,
      KaifuGameAction.updateKfInfo: _updateKfInfo,
    },
  );
}

KaifuGameState _onAction(KaifuGameState state, Action action) {
  final KaifuGameState newState = state.clone();
  return newState;
}

KaifuGameState _updateKfInfo(KaifuGameState state, Action action) {
  final KaifuGameState newState = state.clone();
  newState.kfFragmentState = kf_fragment.initState(action.payload);
  return newState;
}
