import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameHotClassifyState implements Cloneable<GameHotClassifyState> {
  GameSpecial gameSpecial;

  @override
  GameHotClassifyState clone() {
    return GameHotClassifyState()..gameSpecial = gameSpecial;
  }
}

GameHotClassifyState initState(GameSpecial gameSpecial) {
  return GameHotClassifyState()..gameSpecial = gameSpecial;
}
