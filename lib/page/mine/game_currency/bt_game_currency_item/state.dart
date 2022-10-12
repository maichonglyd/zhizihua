import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_curr_bean.dart';

class GameCurrItemState implements Cloneable<GameCurrItemState> {
  GameCurrBean game;
  bool isDown = false;
  bool isWelfare = false;
  bool isZK = false;
  bool isH5 = false;
  @override
  GameCurrItemState clone() {
    return GameCurrItemState()
      ..game = game
      ..isDown = isDown
      ..isWelfare = isWelfare
      ..isZK = isZK
      ..isH5 = isH5;
  }
}

GameCurrItemState initState(GameCurrBean game,
    {bool isDown = false,
    bool isWelfare = false,
    bool isZK = false,
    bool isH5 = false,
    bool isReserved = false}) {
  return GameCurrItemState()
    ..game = game
    ..isDown = isDown
    ..isWelfare = isWelfare
    ..isZK = isZK
    ..isH5 = isH5;
}
