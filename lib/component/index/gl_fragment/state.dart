import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/redux_connector/private_action_mixin.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/index_tab_title/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as index_row_game_state;
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/component/index/gl_fragment/index_tab_title/state.dart'
    as top_title_state;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/state.dart'
    as index_banner_state;

class GlFragmentState implements Cloneable<GlFragmentState> {
  TabController tabController;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  IndexRowGameState indexRowGameState;
  IndexTabTitleState indexTabTitleState;
  IndexTopTabComponentState indexTopTabComponentState;

  List<BTGameItemState> gameStates;
  List<Game> games = [];
  VideoPlayerController videoPlayerController;
  bool hasVolume = true;
  bool isPlaying = true;
  ScrollController scrollController;
  String videoType;
  String type;

  IndexBannerState indexBannerState;
  home_bean.Data homeData;

  List<IndexTopTabBean> topTabList = [];

  @override
  GlFragmentState clone() {
    return GlFragmentState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..videoPlayerController = videoPlayerController
      ..indexRowGameState = indexRowGameState
      ..indexTabTitleState = indexTabTitleState
      ..indexTopTabComponentState = indexTopTabComponentState
      ..games = games
      ..indexBannerState = indexBannerState
      ..type = type
      ..videoType = videoType
      ..homeData = homeData
      ..hasVolume = hasVolume
      ..scrollController = scrollController
      ..isPlaying = isPlaying
      ..gameStates = gameStates
      ..topTabList = topTabList;
  }
}

GlFragmentState initState(String type, String videoType) {
  return GlFragmentState()
//    ..games = new List()
    ..refreshHelper = RefreshHelper()
    ..indexRowGameState = index_row_game_state.initState()
    ..indexBannerState = index_banner_state.initState(videoType + "#0")
    ..type = type
    ..videoType = videoType
    ..refreshHelperController = RefreshHelperController();

//    ..indexCoverImageState =
//        index_cover_image_state.initState(null, null, true, true)
//    ..indexTabTitleState = top_title_state.initState()
//    ..indexTopTabComponentState = top_tab_state.initState()
}
