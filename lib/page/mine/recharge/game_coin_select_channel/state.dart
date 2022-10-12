import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GameCoinSelectChannelState
    implements Cloneable<GameCoinSelectChannelState> {
  Game game;
  @override
  GameCoinSelectChannelState clone() {
    return GameCoinSelectChannelState()..game = game;
  }
}

GameCoinSelectChannelState initState(Game game) {
  return GameCoinSelectChannelState()..game = game;
}
