import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';

class GameRewardBannerState implements Cloneable<GameRewardBannerState> {
  List<GameBannerItem> bannerList = [];

  @override
  GameRewardBannerState clone() {
    return GameRewardBannerState()..bannerList = bannerList;
  }
}

GameRewardBannerState initState(List<GameBannerItem> list) {
  return GameRewardBannerState()..bannerList = list;
}
