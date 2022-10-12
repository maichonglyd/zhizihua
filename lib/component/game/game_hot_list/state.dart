import 'package:fish_redux/fish_redux.dart';

class GameHotListState implements Cloneable<GameHotListState> {

  @override
  GameHotListState clone() {
    return GameHotListState();
  }
}

GameHotListState initState(Map<String, dynamic> args) {
  return GameHotListState();
}
