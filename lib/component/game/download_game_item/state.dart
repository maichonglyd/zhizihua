import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class DownloadGameItemState implements Cloneable<DownloadGameItemState> {
  Game game;
  bool isDown = false;
  bool isWelfare = false;
  bool isZK = false;
  bool isH5 = false;

  //是否是预约
  bool isReserved = false;
  bool isFromDownloadManagerPage = false;

  @override
  DownloadGameItemState clone() {
    return DownloadGameItemState()
      ..game = game
      ..isDown = isDown
      ..isReserved = isReserved
      ..isWelfare = isWelfare
      ..isZK = isZK
      ..isH5 = isH5
      ..isFromDownloadManagerPage = isFromDownloadManagerPage;
  }
}

DownloadGameItemState initState(
    Game game, {
      bool isDown = false,
      bool isWelfare = false,
      bool isZK = false,
      bool isH5 = false,
      bool isReserved = false,
      bool isFromDownloadManagerPage = false,
    }) {
  return DownloadGameItemState()
    ..game = game
    ..isDown = isDown
    ..isWelfare = isWelfare
    ..isReserved = isReserved
    ..isZK = isZK
    ..isH5 = isH5
    ..isFromDownloadManagerPage = isFromDownloadManagerPage;
}
