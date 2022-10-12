import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game;

class GameDetailsGiftFragmentState
    implements Cloneable<GameDetailsGiftFragmentState> {
  int gameId;
  List<Gift> gifts;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  IndexRowGameState rowGameState;

  @override
  GameDetailsGiftFragmentState clone() {
    return GameDetailsGiftFragmentState()
      ..gameId = gameId
      ..refreshHelper = refreshHelper
      ..gifts = gifts
      ..refreshHelperController = refreshHelperController
      ..rowGameState = rowGameState;
  }
}

GameDetailsGiftFragmentState initState(int gameId) {
  return GameDetailsGiftFragmentState()
    ..gameId = gameId
    ..gifts = List()
    ..rowGameState = index_row_game.initState();
}
