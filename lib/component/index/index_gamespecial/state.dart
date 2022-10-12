import 'package:fish_redux/fish_redux.dart';

class GameSpecialState implements Cloneable<GameSpecialState> {
  @override
  GameSpecialState clone() {
    return GameSpecialState();
  }
}

GameSpecialState initState(Map<String, dynamic> args) {
  return GameSpecialState();
}
