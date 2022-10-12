import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GameStrategyMoneyState implements Cloneable<GameStrategyMoneyState> {
  SwiperController swiperController = SwiperController();
  int selectIndex = 0;

  @override
  GameStrategyMoneyState clone() {
    return GameStrategyMoneyState()
      ..swiperController = swiperController
      ..selectIndex = selectIndex;
  }
}

GameStrategyMoneyState initState(Map<String, dynamic> args) {
  return GameStrategyMoneyState();
}
