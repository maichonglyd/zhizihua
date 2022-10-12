import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';

import 'action.dart';

Reducer<JpFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<JpFragmentState>>{
      JpAdapterAction.action: _onAction,
    },
  );
}

JpFragmentState _onAction(JpFragmentState state, Action action) {
  final JpFragmentState newState = state.clone();
  return newState;
}
