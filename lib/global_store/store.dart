import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reducer.dart';
import 'state.dart';

class GlobalStore {
  static Store<GlobalState> _globalStore;

  static Store<GlobalState> get store {
    if (_globalStore == null) {
      AppTheme.init();
      GlobalState globalState = GlobalState()
        ..locale = Locale("zh", "CN");
      //不设置为跟随系统
//      GlobalState globalState = GlobalState();
      _globalStore = createStore<GlobalState>(globalState, buildReducer());
    }
    return _globalStore;
  }
}
