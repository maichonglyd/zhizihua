import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_simple_header/component.dart';
import 'package:flutter_huoshu_app/component/game/game_simple_header/state.dart'
    as game_simple_header;
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_util.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/component.dart';
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/state.dart'
    as index_empty_bottom;
import 'package:flutter_huoshu_app/model/game/game_special.dart';

import 'reducer.dart';
import '../state.dart';

class RmbListAdapter extends DynamicFlowAdapter<RmbFragmentState> {
  RmbListAdapter()
      : super(
          pool: getSpecialGameComponentPool({
            IndexBannerComponent.componentName: IndexBannerComponent(),
            IndexTopTabComponent.componentName: IndexTopTabComponent(),
            IndexRowGameComponent.componentName: IndexRowGameComponent(),
            IndexEmptyBottomComponent.componentName:
                IndexEmptyBottomComponent(),
          }),
          connector: _RmbListConnector(),
        );
}

class _RmbListConnector extends ConnOp<RmbFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(RmbFragmentState state) {
    List<ItemBean> itemBeans = [];

    if (null != state.indexBannerState &&
        state.indexBannerState.gameBannerItems.length > 0) {
      String bannerVideoType = state.videoType + "#0";
      HuoVideoManager.add(HuoVideoViewExt(bannerVideoType, active: true));
      ItemBean itemBean = new ItemBean(
          IndexBannerComponent.componentName,
          state.indexBannerState
            ..isH5 = false
            ..videoType = bannerVideoType);
      itemBeans.add(itemBean);
      //添加banner 视频标记数据
      List<GameBannerItem> bannerList = state.indexBannerState.gameBannerItems;
      for (int i = 0; i < bannerList.length; i++) {
        HuoVideoManager.add(HuoVideoViewExt(bannerVideoType + "#${i}"));
      }
      //设置banner的第一个为可见状态
      HuoVideoManager.setViewActive(bannerVideoType +
          "#${state.indexBannerState.swiperController.index}");
    }

    if (null != state.topTabList && state.topTabList.length > 0) {
      itemBeans.add(ItemBean(
          IndexTopTabComponent.componentName,
          top_tab_state.initState(state.topTabList)
            ..isBT = 1
            ..isH5 = 1
            ..isZK = 1));
    }

    if (null != state.indexRowGameState.games &&
        state.indexRowGameState.games.length > 0) {
      itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
          game_simple_header.initState(GameSpecial()..topicName = "精品游戏推荐")));
      itemBeans.add(ItemBean(
          IndexRowGameComponent.componentName, state.indexRowGameState));
    }

    itemBeans.addAll(getSpecialGameList(
        RmbFragmentComponent.typeName,
        state.videoType,
        state.homeData,
        state.cardPage,
        state.switchSelectIndex,
        state.indexSelectTabState));

    itemBeans.add(ItemBean(IndexEmptyBottomComponent.componentName,
        index_empty_bottom.initState(null)));
    return itemBeans;
  }

  @override
  void set(RmbFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
