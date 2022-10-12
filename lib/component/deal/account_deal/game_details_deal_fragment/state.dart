import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game;

class GameDetailsDealFragmentState
    implements Cloneable<GameDetailsDealFragmentState> {
  int gameId;
  List<DealGoods> dealGoods;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  IndexRowGameState rowGameState;

  @override
  GameDetailsDealFragmentState clone() {
    return GameDetailsDealFragmentState()
      ..gameId = gameId
      ..dealGoods = dealGoods
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..rowGameState = rowGameState;
  }
}

GameDetailsDealFragmentState initState(int gameId) {
  return GameDetailsDealFragmentState()
    ..gameId = gameId
    ..dealGoods = List()
    ..rowGameState = index_row_game.initState();
}

class RowGameConnector
    extends ConnOp<GameDetailsDealFragmentState, IndexRowGameState> {
  @override
  void set(GameDetailsDealFragmentState state, IndexRowGameState subState) {
//    super.set(state, subState);
    state.rowGameState = subState;
  }

  @override
  IndexRowGameState get(GameDetailsDealFragmentState state) {
    return state.rowGameState;
  }
}
