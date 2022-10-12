import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

class DealPlayingState implements Cloneable<DealPlayingState> {
  List<PlayedGame> playedGame;
  @override
  DealPlayingState clone() {
    return DealPlayingState()..playedGame = playedGame;
  }
}

DealPlayingState initState(List<PlayedGame> playedGame) {
  return DealPlayingState()..playedGame = playedGame;
}
