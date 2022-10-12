import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

class GameSimpleHeaderState implements Cloneable<GameSimpleHeaderState> {
  static const int jumpToDefault = 0;
  static const int jumpToKaiFu = 1;
  static const int jumpToStrategy = 2;

  GameSpecial gameSpecial;
  bool showMore = false;
  int moreButtonAction;

  @override
  GameSimpleHeaderState clone() {
    return GameSimpleHeaderState()
      ..gameSpecial = gameSpecial
      ..showMore = showMore
      ..moreButtonAction = moreButtonAction;
  }
}

GameSimpleHeaderState initState(
  GameSpecial gameSpecial, {
  bool showMore = false,
  int moreButtonAction = 0,
}) {
  return GameSimpleHeaderState()
    ..gameSpecial = gameSpecial
    ..showMore = showMore
    ..moreButtonAction = moreButtonAction;
}
