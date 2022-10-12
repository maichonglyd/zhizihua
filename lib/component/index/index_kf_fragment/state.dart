import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart'
    as game_list_fragment;
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart'
    as game_list_state;
import 'package:flutter_huoshu_app/model/init/init_info.dart';

class KfFragmentState implements Cloneable<KfFragmentState> {
  TabController tabController;
  int index;

  GameListState toDayGameListState;
  GameListState newGameListState;
  GameListState oldGameListState;

  List<Mod> tabList = [];

  @override
  KfFragmentState clone() {
    print("KfFragmentState:clone:" + index.toString());
    KfFragmentState state = KfFragmentState()
      ..tabController = tabController
      ..toDayGameListState = toDayGameListState
      ..oldGameListState = oldGameListState
      ..newGameListState = newGameListState
      ..index = index
      ..tabList = tabList;
    return state;
  }
}

KfFragmentState initState(List<Mod> tabList) {
  int type = GameListState.TYPE_BT;
  if (null != tabList && tabList.length > 0) {
    type = getKfIndex(tabList[0]);
  }
  return KfFragmentState()
    ..index = 0
    ..tabList = tabList
    ..toDayGameListState = game_list_state.initState(
        GameListState.TYPE_PAGE_KF, type, kfType: GameListState.TYPE_KF_TODAY)
    ..newGameListState = game_list_state.initState(
        GameListState.TYPE_PAGE_KF, type, kfType: GameListState.TYPE_KF_NEW)
    ..oldGameListState = game_list_state.initState(
        GameListState.TYPE_PAGE_KF, type,
        kfType: GameListState.TYPE_KF_OLD);
}

class ToDayGameListFragmentConnector
    extends ConnOp<KfFragmentState, game_list_fragment.GameListState> {
  @override
  void set(KfFragmentState state, game_list_fragment.GameListState subState) {
//    super.set(state, subState);
    state.toDayGameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(KfFragmentState state) {
//    return state.toDayGameListState..type = state.index+1;
    return state.toDayGameListState
      ..type = getKfIndex(state.tabList[state.index]);
  }
}

class NewGameListFragmentConnector
    extends ConnOp<KfFragmentState, game_list_fragment.GameListState> {
  @override
  void set(KfFragmentState state, game_list_fragment.GameListState subState) {
//    super.set(state, subState);
    state.newGameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(KfFragmentState state) {
//    return state.newGameListState..type = state.index+1;
    return state.newGameListState
      ..type = getKfIndex(state.tabList[state.index]);
  }
}

class OldGameListFragmentConnector
    extends ConnOp<KfFragmentState, game_list_fragment.GameListState> {
  @override
  void set(KfFragmentState state, game_list_fragment.GameListState subState) {
//    super.set(state, subState);
    state.oldGameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(KfFragmentState state) {
//    return state.oldGameListState..type = state.index+1;
    return state.oldGameListState
      ..type = getKfIndex(state.tabList[state.index]);
  }
}

int getKfIndex(Mod mod) {
  int type = GameListState.TYPE_BT;
  switch (mod.type) {
    case 'bt':
      type = GameListState.TYPE_BT;
      break;
    case 'rate':
      type = GameListState.TYPE_ZK;
      break;
    case 'h5':
      type = GameListState.TYPE_H5;
      break;
  }
  return type;
}
