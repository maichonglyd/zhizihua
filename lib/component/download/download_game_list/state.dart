import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class DownLoadGameListState implements Cloneable<DownLoadGameListState> {
  List<Game> games;
  int status = 0; //0 下载中 1 下载完成 2已预约

  @override
  DownLoadGameListState clone() {
    return DownLoadGameListState()
      ..games = games
      ..status = status;
  }
}

DownLoadGameListState initState(int status) {
  return DownLoadGameListState()
    ..games = List()
    ..status = status;
}
