import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IndexBannerState with GlobalBaseState<IndexBannerState> {
  List<GameBannerItem> gameBannerItems;

  SwiperController swiperController = (SwiperController()..index = 0);
  List<New> news;
  bool isShowVolume;
  String videoType;
  bool hasVideo;

  //是否是h5游戏,h5游戏不需要下载直接进入群聊
  bool isH5 = false;

  @override
  IndexBannerState clone() {
    return IndexBannerState()
      ..copyGlobalFrom(this)
      ..news = news
      ..swiperController = swiperController
      ..videoType = videoType
      ..hasVideo = hasVideo
      ..isH5 = isH5
      ..isShowVolume = isShowVolume
      ..gameBannerItems = gameBannerItems;
  }
}

IndexBannerState initState(String videoType) {
  //just demo, do nothing here...
  return IndexBannerState()
    ..videoType = videoType
    ..gameBannerItems = new List()
    ..news = new List();
}
