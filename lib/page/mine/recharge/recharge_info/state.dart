import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class RechargeInfoState implements Cloneable<RechargeInfoState> {
  Game game;
  int gameId;

  @override
  RechargeInfoState clone() {
    return RechargeInfoState()..game = game;
  }
}

RechargeInfoState initState(Map<String, dynamic> args) {
  return RechargeInfoState()
    ..gameId =
        (args != null && args['game_id'] != null) ? args['game_id'] : null
    ..game = (args != null && args['game'] != null) ? args['game'] : null;
}
