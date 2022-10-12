import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

class IndexPlayedItemState implements Cloneable<IndexPlayedItemState> {
  PlayedList playedList;
  @override
  IndexPlayedItemState clone() {
    return IndexPlayedItemState()..playedList = playedList;
  }
}

IndexPlayedItemState initState(Map<String, dynamic> args) {
  return IndexPlayedItemState();
}
