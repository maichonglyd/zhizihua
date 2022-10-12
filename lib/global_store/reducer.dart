import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/global_store/action.dart';

import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
      GlobalAction.changeLocale: _changeLocale,
    },
  );
}

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  return state.clone();
}

GlobalState _changeLocale(GlobalState state, Action action) {
  return state.clone()..locale = action.payload;
}
