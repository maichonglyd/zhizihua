import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameCoinSelectGameState implements Cloneable<GameCoinSelectGameState> {
  TextEditingController textEditingController = TextEditingController();
  List<Game> games = [];
  @override
  GameCoinSelectGameState clone() {
    return GameCoinSelectGameState();
  }
}

GameCoinSelectGameState initState(Map<String, dynamic> args) {
  return GameCoinSelectGameState();
}
