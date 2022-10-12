import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../huo_video_manager.dart';

class VideoState implements Cloneable<VideoState> {
  SwiperController swiperController;
  List<New> news = List();
  double volume = 0;
  bool isSliding = false;
  double sliderVal = 0;

  //视频是否有声音
  bool isShowVolume = false;
  int index = 0;
  String videoType;

  @override
  VideoState clone() {
    return VideoState()
      ..swiperController = swiperController
      ..volume = volume
      ..isSliding = isSliding
      ..isShowVolume = isShowVolume
      ..index = index
      ..videoType = videoType
      ..news = news;
  }
}

VideoState initState(String videoType) {
  HuoVideoManager.add(new HuoVideoViewExt(videoType));
  return VideoState()
    ..videoType = videoType
    ..swiperController = (SwiperController()..index = 0)
    ..news = List();
}
