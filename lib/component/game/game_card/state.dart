import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameCardState implements Cloneable<GameCardState> {
  GameSpecial gameSpecial;
  num topicId = 0;
  int page = 1;
  String type;

  @override
  GameCardState clone() {
    return GameCardState()
      ..gameSpecial = gameSpecial
      ..topicId = topicId
      ..page = page
      ..type = type;
  }
}

GameCardState initState(String type, int page, GameSpecial gameSpecial) {
  return GameCardState()
    ..gameSpecial = gameSpecial
    ..topicId = gameSpecial.topicId
    ..type = type
    ..page = page;
}
