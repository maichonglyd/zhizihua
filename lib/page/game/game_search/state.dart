import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/search_hot_list.dart';
import 'package:flutter_huoshu_app/repository/game_history_repository.dart';

class GameSearchState implements Cloneable<GameSearchState> {
  TextEditingController contentController = TextEditingController();
  List<GameHistory> gameHistoryList;
  List<Game> games;
  List<DataBean> hotGames;

  @override
  GameSearchState clone() {
    return GameSearchState()
      ..gameHistoryList = gameHistoryList
      ..contentController = contentController
      ..games = games
      ..hotGames = hotGames;
  }
}

GameSearchState initState(Map<String, dynamic> args) {
  return GameSearchState()
    ..gameHistoryList = List()
    ..games = List()
    ..hotGames = List();
}
