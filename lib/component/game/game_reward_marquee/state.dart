import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

class GameRewardMarqueeState implements Cloneable<GameRewardMarqueeState> {
  List<AppIndexTextListData> list;

  @override
  GameRewardMarqueeState clone() {
    return GameRewardMarqueeState()..list = list;
  }
}

GameRewardMarqueeState initState(List<AppIndexTextListData> list) {
  return GameRewardMarqueeState()..list = list;
}
