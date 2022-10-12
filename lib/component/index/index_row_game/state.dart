import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game_dto.dart';

class IndexRowGameState implements Cloneable<IndexRowGameState> {
  List<Game> games;
  bool showLine = false;

  @override
  IndexRowGameState clone() {
    return IndexRowGameState()
      ..games = games
      ..showLine = showLine;
  }
}

IndexRowGameState initState({bool showLine}) {
  if (showLine == null) showLine = false;
  return IndexRowGameState()
    ..games = List()
    ..showLine = showLine;
}
