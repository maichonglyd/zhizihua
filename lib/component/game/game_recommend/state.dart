import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameRecommendState implements Cloneable<GameRecommendState> {
  GameSpecial gameSpecial;

  @override
  GameRecommendState clone() {
    return GameRecommendState()..gameSpecial = gameSpecial;
  }
}

GameRecommendState initState(GameSpecial gameSpecial) {
  return GameRecommendState()..gameSpecial = gameSpecial;
}
