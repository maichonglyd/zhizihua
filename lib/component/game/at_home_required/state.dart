import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class AtHomeRequiredState implements Cloneable<AtHomeRequiredState> {
  List<Game> games;
  @override
  AtHomeRequiredState clone() {
    return AtHomeRequiredState()..games = games;
  }
}

AtHomeRequiredState initState(Map<String, dynamic> args) {
  List<Game> games;
  return AtHomeRequiredState()..games = List();
}
