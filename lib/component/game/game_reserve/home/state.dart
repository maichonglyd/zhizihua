import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

class NewGameReserveState implements Cloneable<NewGameReserveState> {
//  List<HomeNotice> news = List();
  List<Game> games = List();
  int isBT = 0;
  int isZK = 0;
  int isH5 = 0;
  String topicName = "";

  @override
  NewGameReserveState clone() {
    return NewGameReserveState()
      ..games = games
      ..isZK = isZK
      ..isH5 = isH5
      ..topicName = topicName
      ..isBT = isBT;
  }
}

NewGameReserveState initState() {
  return NewGameReserveState()..games = List();
}
