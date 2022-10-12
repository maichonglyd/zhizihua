import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class JPGameItemState implements Cloneable<JPGameItemState> {
  Game game;

  @override
  JPGameItemState clone() {
    return JPGameItemState()..game = game;
  }
}

JPGameItemState initState(Map<String, dynamic> args) {
  return JPGameItemState();
}
