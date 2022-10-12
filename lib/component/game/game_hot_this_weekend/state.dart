import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameHotThisWeekendState implements Cloneable<GameHotThisWeekendState> {
  GameSpecial gameSpecial;

  @override
  GameHotThisWeekendState clone() {
    return GameHotThisWeekendState()..gameSpecial = gameSpecial;
  }
}

GameHotThisWeekendState initState(GameSpecial gameSpecial) {
  return GameHotThisWeekendState()..gameSpecial = gameSpecial;
}
