import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

import '../state.dart';
import 'action.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;

Reducer<GameCurrencyListState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameCurrencyListState>>{
      GameCurrencyListAdapterAction.update: _update,
    },
  );
}

GameCurrencyListState _onAction(GameCurrencyListState state, Action action) {
  final GameCurrencyListState newState = state.clone();
  return newState;
}

GameCurrencyListState _update(GameCurrencyListState state, Action action) {
  final GameCurrencyListState newState = state.clone();
//  home_bean.Data data = action.payload;
  return newState;
}
