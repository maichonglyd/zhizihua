import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';

class RebateGameItemState implements Cloneable<RebateGameItemState> {
  RebateGame rebateGame;
  @override
  RebateGameItemState clone() {
    return RebateGameItemState()..rebateGame = rebateGame;
  }
}

RebateGameItemState initState(RebateGame rebateGame) {
  return RebateGameItemState()..rebateGame = rebateGame;
}
