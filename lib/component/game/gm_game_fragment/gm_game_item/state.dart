import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class GmGameItemState implements Cloneable<GmGameItemState> {
  Game game;
  int type = 0; //0 gm游戏 1 gm助手
  @override
  GmGameItemState clone() {
    return GmGameItemState();
  }
}

GmGameItemState initState(Game game) {
  return GmGameItemState()..game = game;
}
