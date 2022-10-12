import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/game/game_details_images/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart'
    as game_comments;
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_huoshu_app/component/game/game_details_images/state.dart'
    as game_details_image_state;

class GameDetailsComponentState
    implements Cloneable<GameDetailsComponentState> {
  List<ImageMod> images;
  List<New> news;
  VideoPlayerController videoPlayerController;
  ScrollController scrollController;

  String desc;
  CommentStar starCnt; //10分5星制
  int gameId;
  List<game_comments.Comment> comments = List();
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  GameDetailsImagesState gameDetailsImagesState;
  bool hasVolume = true;
  int isBt = 0;
  Vip vipDescription;
  List<News> activityNews;
  List<Game> gameList;

  @override
  GameDetailsComponentState clone() {
    return GameDetailsComponentState()
      ..images = images
      ..news = news
      ..hasVolume = hasVolume
      ..desc = desc
      ..starCnt = starCnt
      ..gameId = gameId
      ..comments = comments
      ..gameDetailsImagesState = gameDetailsImagesState
      ..refreshHelper = refreshHelper
      ..scrollController = scrollController
      ..videoPlayerController = videoPlayerController
      ..refreshHelperController = refreshHelperController
      ..isBt = isBt
      ..vipDescription = vipDescription
      ..activityNews = activityNews
      ..gameList = gameList;
  }
}

GameDetailsComponentState initState(
    List<ImageMod> images,
    List<New> news,
    decs,
    CommentStar starCnt,
    int gameId,
    int isBt,
    Vip vipDescription,
    List<News> activityNews,
    List<Game> gameList) {
  return GameDetailsComponentState()
    ..images = images
    ..news = news
    ..desc = decs
    ..starCnt = starCnt
    ..gameId = gameId
    ..comments = List()
    ..isBt = isBt
    ..vipDescription = vipDescription
    ..activityNews = activityNews
    ..gameList = gameList;
}
