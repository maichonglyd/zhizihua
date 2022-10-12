import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart'
    as game_list_fragment;
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart'
    as game_list_state;
import 'package:flutter_huoshu_app/component/game_list_fragment/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_type.dart' as game_type;

class GameClassifyState implements Cloneable<GameClassifyState> {
  int index = 0;
  int typeIndex = 0;
  GameListState gameListState = game_list_state.initState(
      GameListState.TYPE_PAGE_CLASSIFY, GameListState.TYPE_ALL);
  List<Game> games = List();
  game_type.Data gameType;

  @override
  GameClassifyState clone() {
    return GameClassifyState()
      ..games = games
      ..gameType = gameType
      ..index = index
      ..gameListState = gameListState
      ..typeIndex = typeIndex;
  }
}

GameClassifyState initState(Map<String, dynamic> args) {
  return GameClassifyState()..games = List();
}

class GameListFragmentConnector
    extends ConnOp<GameClassifyState, game_list_fragment.GameListState> {
  @override
  void set(GameClassifyState state, game_list_fragment.GameListState subState) {
//    super.set(state, subState);
    state.gameListState = subState;
  }

  @override
  game_list_fragment.GameListState get(GameClassifyState state) {
    return state.gameListState;
  }
}
