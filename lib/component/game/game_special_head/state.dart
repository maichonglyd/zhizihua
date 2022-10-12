import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GameSpecialHeadState implements Cloneable<GameSpecialHeadState> {
  GameSpecial gameSpecial;
  bool isWelfare = false;
  bool isZK = false;
  SwiperController swiperController = SwiperController();
  String videoType;

  @override
  GameSpecialHeadState clone() {
    return GameSpecialHeadState()
      ..gameSpecial = gameSpecial
      ..isWelfare = isWelfare
      ..swiperController = swiperController
      ..isZK = isZK
      ..videoType = videoType;
  }
}

GameSpecialHeadState initState(String videoType, {bool isWelfare = false, bool isZK = false}) {
  if (null != videoType && videoType.isNotEmpty) {
    HuoVideoManager.add(HuoVideoViewExt(videoType));
  }
  return GameSpecialHeadState()
    ..isWelfare = isWelfare
    ..isZK = isZK
    ..swiperController = SwiperController()..videoType = videoType;
}
