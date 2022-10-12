import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/index_tab_title/component.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/jp_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/component/index/gl_fragment/index_tab_title/state.dart'
    as index_tab_title_state;
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import '../reducer.dart';

class GlAdapter extends DynamicFlowAdapter<GlFragmentState> {
  GlAdapter()
      : super(
          pool: <String, Component<Object>>{
//            IndexCoverImageComponent.componentName: IndexCoverImageComponent(),
            IndexBannerComponent.componentName: IndexBannerComponent(),
            IndexTopTabComponent.componentName: IndexTopTabComponent(),
            IndexTabTitleComponent.componentName: IndexTabTitleComponent(),
            BTGameItemComponent.componentName: BTGameItemComponent(),
          },
          connector: _GlAdapterConnector(),
          reducer: buildReducer(),
        );
}

class _GlAdapterConnector extends ConnOp<GlFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(GlFragmentState state) {
    List<ItemBean> itemBeans = new List();
    if (state.indexBannerState.gameBannerItems.length > 0) {
      String bannerVideoType = state.videoType + "#0";
      HuoVideoManager.add(HuoVideoViewExt(bannerVideoType, active: true));
      ItemBean itemBean = new ItemBean(
          IndexBannerComponent.componentName,
          state.indexBannerState
            ..isH5 = false
            ..videoType = bannerVideoType);
      itemBeans.insert(0, itemBean);
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
      itemBeans.add(ItemBean(IndexTopTabComponent.componentName,
          top_tab_state.initState(state.topTabList)));
    }

    //添加标题栏
    itemBeans.add(new ItemBean(IndexTabTitleComponent.componentName,
        index_tab_title_state.initState()));

    if (state.games != null) {
      for (Game game in state.games) {
        itemBeans.add(new ItemBean(
            BTGameItemComponent.componentName,
            BTGameItemState()
              ..game = game
              ..isWelfare = false));
      }
    }

    return itemBeans;
  }

  @override
  void set(GlFragmentState state, List<ItemBean> items) {
    for (ItemBean item in items) {
      if (IndexTabTitleComponent.componentName == item.type) {
        state.indexTabTitleState = item.data;
        continue;
      }
      if (IndexRowGameComponent.componentName == item.type) {
        state.indexRowGameState = item.data;
        continue;
      }
//      if (IndexCoverImageComponent.componentName == item.type) {
//        state.indexCoverImageState = item.data;
//        continue;
//      }
    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
