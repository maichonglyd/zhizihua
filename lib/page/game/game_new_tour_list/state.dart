import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/game/game_new_round_list/state.dart';
import 'package:flutter_huoshu_app/component/game/game_new_round_list/state.dart'
    as game_new_round_list;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameNewTourListState implements Cloneable<GameNewTourListState> {
  static const int gameNewTourListTypeWeekend = 1;
  static const int gameNewTourListTypeComment = 2;
  static const int gameNewTourListTypeOrder = 3;

  List<String> tabs = [getText(name: 'textNewGameWeekTop'), getText(name: 'textNewGameCommentList'), getText(name: 'textNewGameRoundList')];
  int tabIndex = 0;

  GameNewRoundListState firstGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeWeekend);
  GameNewRoundListState secondGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeComment);
  GameNewRoundListState thirdGameNewRoundListState =
      game_new_round_list.initState(gameNewTourListTypeOrder);
  List<Game> firstGameList = [];
  List<Game> secondGameList = [];
  List<Game> thirdGameList = [];

  @override
  GameNewTourListState clone() {
    return GameNewTourListState()
      ..tabs = tabs
      ..tabIndex = tabIndex
      ..firstGameNewRoundListState = firstGameNewRoundListState
      ..secondGameNewRoundListState = secondGameNewRoundListState
      ..thirdGameNewRoundListState = thirdGameNewRoundListState
      ..firstGameList = firstGameList
      ..secondGameList = secondGameList
      ..thirdGameList = thirdGameList;
  }
}

GameNewTourListState initState(Map<String, dynamic> args) {
  return GameNewTourListState()..tabIndex = null == args ? 0 : args['tabIndex'];
}

class FirstGameNewRoundListFragmentConnector
    extends ConnOp<GameNewTourListState, GameNewRoundListState> {
  @override
  void set(GameNewTourListState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.firstGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(GameNewTourListState state) {
    return state.firstGameNewRoundListState;
  }
}

class SecondGameNewRoundListFragmentConnector
    extends ConnOp<GameNewTourListState, GameNewRoundListState> {
  @override
  void set(GameNewTourListState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.secondGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(GameNewTourListState state) {
    return state.secondGameNewRoundListState;
  }
}

class ThirdGameNewRoundListFragmentConnector
    extends ConnOp<GameNewTourListState, GameNewRoundListState> {
  @override
  void set(GameNewTourListState state, GameNewRoundListState subState) {
//    super.set(state, subState);
    state.thirdGameNewRoundListState = subState;
  }

  @override
  GameNewRoundListState get(GameNewTourListState state) {
    return state.thirdGameNewRoundListState;
  }
}
