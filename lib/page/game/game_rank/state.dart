import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart'
    as game_list_fragment;
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart'
    as game_list_state;

class GameRankState implements Cloneable<GameRankState> {
  GameListState btGameListState = game_list_state.initState(
      GameListState.TYPE_PAGE_RANK, GameListState.TYPE_BT);
  GameListState zkGameListState = game_list_state.initState(
      GameListState.TYPE_PAGE_RANK, GameListState.TYPE_ZK);
  GameListState h5GameListState = game_list_state.initState(
      GameListState.TYPE_PAGE_RANK, GameListState.TYPE_H5);

  @override
  GameRankState clone() {
    return GameRankState()
      ..btGameListState = btGameListState
      ..zkGameListState = zkGameListState
      ..h5GameListState = h5GameListState;
  }
}

GameRankState initState(Map<String, dynamic> args) {
  return GameRankState();
}

class BtGameListFragmentConnector
    extends ConnOp<GameRankState, game_list_fragment.GameListState> {
  @override
  void set(GameRankState state, game_list_fragment.GameListState subState) {
    state.btGameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(GameRankState state) {
    return state.btGameListState;
  }
}

class ZkGameListFragmentConnector
    extends ConnOp<GameRankState, game_list_fragment.GameListState> {
  @override
  void set(GameRankState state, game_list_fragment.GameListState subState) {
    state.zkGameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(GameRankState state) {
    return state.zkGameListState;
  }
}

class H5GameListFragmentConnector
    extends ConnOp<GameRankState, game_list_fragment.GameListState> {
  @override
  void set(GameRankState state, game_list_fragment.GameListState subState) {
//    super.set(state, subState);
    state.h5GameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(GameRankState state) {
    return state.h5GameListState;
  }
}
