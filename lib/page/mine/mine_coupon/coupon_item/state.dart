import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class CouponItemState implements Cloneable<CouponItemState> {
//  Game game;
  String game;
  bool isDown = false;

  @override
  CouponItemState clone() {
    return CouponItemState()
      ..game = game
      ..isDown = isDown;
  }
}

CouponItemState initState(String game, {bool isDown = false}) {
  return CouponItemState()
    ..game = game
    ..isDown = isDown;
}

//CouponItemState initState(Game game,
//    {bool isDown = false}) {
//  return CouponItemState()
//    ..game = game
//    ..isDown = isDown;
//}
