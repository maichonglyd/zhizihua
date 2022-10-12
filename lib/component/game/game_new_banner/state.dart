import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';

class GameNewBannerState implements Cloneable<GameNewBannerState> {
  List<GameBannerItem> bannerList = [];

  @override
  GameNewBannerState clone() {
    return GameNewBannerState()..bannerList = bannerList;
  }
}

GameNewBannerState initState(List<GameBannerItem> list) {
  return GameNewBannerState()..bannerList = list;
}
