import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/at_home_required/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/component.dart';
import 'package:flutter_huoshu_app/component/game/must_play_daily/component.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/component.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/h5_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/component.dart';
import 'package:flutter_huoshu_app/component/index/index_gamespecial/component.dart';
import 'package:flutter_huoshu_app/component/index/index_played_item/component.dart';
import 'package:flutter_huoshu_app/component/index/index_recommend/component.dart';

import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as row_game_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as select_tab_state;
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/state.dart'
as index_empty_bottom;
import 'package:flutter_huoshu_app/component/index/index_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

import '../../index_recommend1/component.dart';
import '../../index_recommend1/component.dart';
import '../state.dart';

class H5ListAdapter extends DynamicFlowAdapter<H5FragmentState> {
  H5ListAdapter()
      : super(
          pool: getSpecialGameComponentPool({
            IndexBannerComponent.componentName: IndexBannerComponent(),
            IndexRowGameComponent.componentName: IndexRowGameComponent(),
            IndexPlayedItemComponent.componentName: IndexPlayedItemComponent(),
            IndexEmptyBottomComponent.componentName:
                IndexEmptyBottomComponent(),
          }),
          connector: _BTListConnector(),
        );
}

class _BTListConnector extends ConnOp<H5FragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(H5FragmentState state) {
    List<ItemBean> itemBeans = [];

    if (state.indexBannerState.gameBannerItems.length > 0) {
      String bannerVideoType = state.videoType + "#0";
      HuoVideoManager.add(HuoVideoViewExt(bannerVideoType, active: true));
      ItemBean itemBean = new ItemBean(
          IndexBannerComponent.componentName,
          state.indexBannerState
            ..isH5 = true
            ..videoType = bannerVideoType);
      itemBeans.add(itemBean);

      //添加banner 视频标记数据
      List<GameBannerItem> bannerList = state.indexBannerState.gameBannerItems;
      for (int i = 0; i < bannerList.length; i++) {
        HuoVideoManager.add(HuoVideoViewExt(bannerVideoType + "#${i}"));
      }
      //设置banner的第一个为可见状态
      if (state.indexBannerState.swiperController != null) {
        HuoVideoManager.setViewActive(bannerVideoType +
            "#${state.indexBannerState.swiperController.index}");
      }
    }

    if (state.indexBannerState.gameBannerItems.length > 0) {
      itemBeans.add(ItemBean(
          IndexRowGameComponent.componentName, state.indexRowGameState));
    }

    if (state.indexPlayedItemState != null) {
      itemBeans.add(new ItemBean(
          IndexPlayedItemComponent.componentName, state.indexPlayedItemState));
    }

    if (state.gameStates != null) {
      for (BTGameItemState state in state.gameStates) {
        itemBeans.add(new ItemBean(BTGameItemComponent.componentName, state));
      }
    }

    itemBeans.addAll(getSpecialGameList(
        H5FragmentComponent.typeName,
        state.videoType,
        state.homeData,
        state.cardPage,
        state.switchData,
        state.indexSelectTabState,
        isH5: true));

    itemBeans.add(ItemBean(IndexEmptyBottomComponent.componentName,
        index_empty_bottom.initState(null)));
    return itemBeans;
  }

  @override
  void set(H5FragmentState state, List<ItemBean> items) {
    for (ItemBean item in items) {
      if (IndexSelectTabComponent.componentName == item.type) {
        continue;
      }
      if (IndexRowGameComponent.componentName == item.type) {
        state.indexRowGameState = item.data;
        continue;
      }
      if (IndexBannerComponent.componentName == item.type) {
        state.indexBannerState = item.data;
        continue;
      }
    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
