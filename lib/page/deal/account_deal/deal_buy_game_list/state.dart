import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';

class DealBuyGameListState implements Cloneable<DealBuyGameListState> {
  List<PlayedGame> playedGames;

  @override
  DealBuyGameListState clone() {
    return DealBuyGameListState()..playedGames = playedGames;
  }
}

DealBuyGameListState initState(Map<String, dynamic> args) {
  return DealBuyGameListState()..playedGames = List();
}
