import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

class PlayingListState implements Cloneable<PlayingListState> {
  List<PlayedGame> playedGames;
  @override
  PlayingListState clone() {
    return PlayingListState()..playedGames = playedGames;
  }
}

PlayingListState initState(Map<String, dynamic> args) {
  return PlayingListState()..playedGames = List();
}
