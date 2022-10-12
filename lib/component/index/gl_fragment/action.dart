import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/redux_connector/private_action_mixin.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:video_player/video_player.dart';

//首页单列表游戏列表
enum GlFragmentAction {
  update,
  getHomeByGl,
  getHomeData,
  updateType,
  refreshComplete,
  createPlayController,
  createController,
  changeVideoVolume,
  updateVolume,
  changeVideoState,
  updatePlaying,
  updateIndex,
  updateHomeData,
  getTopTabList,
  updateTopTabList,
}

class GlFragmentActionCreator {
  static Action onCreateController(ScrollController scrollController) {
    return Action(GlFragmentAction.createController,
        payload: {"scrollController": scrollController});
  }

  static Action getHomeByGl(int page) {
    return Action(GlFragmentAction.getHomeByGl, payload: page);
  }

  static Action update(List<Game> games) {
    return Action(GlFragmentAction.update, payload: games);
  }

  static Action updateIndex(int index) {
    return Action(GlFragmentAction.updateIndex, payload: index);
  }

  static Action updateHomeData(home_bean.Data homeData) {
    return Action(GlFragmentAction.updateHomeData, payload: homeData);
  }

  static Action getTopTabList() {
    return const Action(GlFragmentAction.getTopTabList);
  }

  static Action updateTopTabList(List<IndexTopTabBean> list) {
    return Action(GlFragmentAction.updateTopTabList, payload: list);
  }
}
