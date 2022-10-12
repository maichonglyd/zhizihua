import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class BTGameItemState implements Cloneable<BTGameItemState> {
  Game game;
  bool isDown = false;
  bool isWelfare = false;
  bool isZK = false;
  bool isH5 = false;

  //是否是预约
  bool isReserved = false;

  // 开服类型
  int kfType = 0;

  @override
  BTGameItemState clone() {
    return BTGameItemState()
      ..game = game
      ..isDown = isDown
      ..isReserved = isReserved
      ..isWelfare = isWelfare
      ..isZK = isZK
      ..isH5 = isH5
      ..kfType = kfType;
  }
}

BTGameItemState initState(
  Game game, {
  bool isDown = false,
  bool isWelfare = false,
  bool isZK = false,
  bool isH5 = false,
  bool isReserved = false,
  int kfType = 1,
}) {
  return BTGameItemState()
    ..game = game
    ..isDown = isDown
    ..isWelfare = isWelfare
    ..isReserved = isReserved
    ..isZK = isZK
    ..isH5 = isH5
    ..kfType = kfType;
}
