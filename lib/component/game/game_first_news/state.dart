import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameFirstNewsState implements Cloneable<GameFirstNewsState> {
  GameSpecial gameSpecial;

  @override
  GameFirstNewsState clone() {
    return GameFirstNewsState()..gameSpecial = gameSpecial;
  }
}

GameFirstNewsState initState(GameSpecial gameSpecial) {
  return GameFirstNewsState()..gameSpecial = gameSpecial;
}
