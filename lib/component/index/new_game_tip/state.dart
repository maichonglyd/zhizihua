import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class NewGameTipState implements Cloneable<NewGameTipState> {
  List<Game> games;
  @override
  NewGameTipState clone() {
    return NewGameTipState()..games = games;
  }
}

NewGameTipState initState() {
  return NewGameTipState()..games = List();
}
