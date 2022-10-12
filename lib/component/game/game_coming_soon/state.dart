import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameComingSoonState implements Cloneable<GameComingSoonState> {
  List<ServerBean> serverList;

  @override
  GameComingSoonState clone() {
    return GameComingSoonState()..serverList = serverList;
  }
}

GameComingSoonState initState(GameSpecial gameSpecial) {
  return GameComingSoonState()..serverList = gameSpecial.serverList;
}
