import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game;
import 'package:flutter_huoshu_app/model/coupon/coupon_game_list.dart';

class GameDetailsRebateState implements Cloneable<GameDetailsRebateState> {
  IndexRowGameState rowGameState;
  String rebateDescription;
  CouponGameList couponGameList;

  @override
  GameDetailsRebateState clone() {
    return GameDetailsRebateState()
      ..rowGameState = rowGameState
      ..rebateDescription = rebateDescription
      ..couponGameList = couponGameList;
  }
}

GameDetailsRebateState initState(String rebateDescription,
    {CouponGameList couponGameList}) {
  return GameDetailsRebateState()
    ..rowGameState = index_row_game.initState()
    ..rebateDescription = rebateDescription
    ..couponGameList = couponGameList;
}

class RowGameConnector
    extends ConnOp<GameDetailsRebateState, IndexRowGameState> {
  @override
  void set(GameDetailsRebateState state, IndexRowGameState subState) {
//    super.set(state, subState);
    state.rowGameState = subState;
  }

  @override
  IndexRowGameState get(GameDetailsRebateState state) {
    return state.rowGameState;
  }
}
