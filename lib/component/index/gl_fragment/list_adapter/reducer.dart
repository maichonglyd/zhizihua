import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';

import 'action.dart';

//这个类都要不然联系不上adapter
Reducer<GlFragmentState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlFragmentState>>{
      GlAdapterAction.action: _onAction,
    },
  );
}

GlFragmentState _onAction(GlFragmentState state, Action action) {
  final GlFragmentState newState = state.clone();
  return newState;
}
