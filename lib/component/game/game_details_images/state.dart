import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:video_player/video_player.dart';

//Image这个类cupertino库里面本来就有了,以后实体对象命名规范不能用Image这个命名,这里面的赋值都失效了
class GameDetailsImagesState implements Cloneable<GameDetailsImagesState> {
  List<ImageMod> images;
  List<New> news;
  String dec;
  ScrollController scrollController;
  VideoPlayerController videoPlayerController;
  bool initialized = false; // videoPlayer 是否init
  bool isPlay = true; // videoPlayer 是否init
  //视频是否有声音
  bool hasVolume = true;
  int isBt = 0;
  Vip vipDescription;
  int activityIndex = 0;
  List<News> activityNews = [];
  List<Game> gameList = [];

  @override
  GameDetailsImagesState clone() {
    return GameDetailsImagesState()
      ..images = images
      ..isPlay = isPlay
      ..hasVolume = hasVolume
      ..initialized = initialized
      ..scrollController = scrollController
      ..videoPlayerController = videoPlayerController
      ..news = news
      ..dec = dec
      ..isBt = isBt
      ..vipDescription = vipDescription
      ..activityIndex = activityIndex
      ..activityNews = activityNews
      ..gameList = gameList;
  }
}

GameDetailsImagesState initState(
    List<ImageMod> images,
    List<New> news,
    String dec,
    VideoPlayerController videoPlayerController,
    ScrollController scrollController,
    bool hasVolume,
    int isBt,
    Vip vipDescription,
    List<News> activityNews,
    List<Game> gameList) {
  HuoVideoViewExt ext =
      HuoVideoViewExt(HuoVideoManager.type_game_detail, active: true);
  HuoVideoManager.add(ext);
  HuoVideoManager.setViewActive(ext.type);
  return GameDetailsImagesState()
    ..images = images
    ..news = news
    ..hasVolume = hasVolume
    ..videoPlayerController = videoPlayerController
    ..scrollController = scrollController
    ..dec = dec
    ..isBt = isBt
    ..vipDescription = vipDescription
    ..activityNews = activityNews
    ..gameList = gameList;
}
