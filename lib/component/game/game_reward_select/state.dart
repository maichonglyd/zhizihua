import 'package:fish_redux/fish_redux.dart';

class GameRewardSelectState implements Cloneable<GameRewardSelectState> {

  @override
  GameRewardSelectState clone() {
    return GameRewardSelectState();
  }
}

GameRewardSelectState initState(Map<String, dynamic> args) {
  return GameRewardSelectState();
}
