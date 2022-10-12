import 'package:fish_redux/fish_redux.dart';

import 'package:flutter_huoshu_app/component/game/game_reward_banner/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_banner/state.dart'
    as game_reward_banner;
import 'package:flutter_huoshu_app/component/game/game_reward_marquee/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_marquee/state.dart'
    as game_reward_marquee;
import 'package:flutter_huoshu_app/component/game/game_reward_select/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_select/state.dart'
    as game_reward_select;
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/component.dart';
import 'package:flutter_huoshu_app/component/index/index_empty_bottom/state.dart'
    as index_empty_bottom;
import 'package:flutter_huoshu_app/component/index/index_util.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';

import 'reducer.dart';
import '../state.dart';

class HbListAdapterAdapter extends DynamicFlowAdapter<HbFragmentState> {
  HbListAdapterAdapter()
      : super(
          pool: getSpecialGameComponentPool({
            GameRewardBannerComponent.componentName:
                GameRewardBannerComponent(),
            GameRewardMarqueeComponent.componentName:
                GameRewardMarqueeComponent(),
            GameRewardSelectComponent.componentName:
                GameRewardSelectComponent(),
            IndexEmptyBottomComponent.componentName:
                IndexEmptyBottomComponent(),
          }),
          connector: _HbListAdapterConnector(),
        );
}

class _HbListAdapterConnector extends ConnOp<HbFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(HbFragmentState state) {
    List<ItemBean> itemBeans = [];
    if (null != state.bannerState) {
      itemBeans.add(new ItemBean(
          GameRewardBannerComponent.componentName, state.bannerState));
    }
    if (null != state.homeData &&
        null != state.homeData.appIndexTextList &&
        state.homeData.appIndexTextList.list.length > 0) {
      // 过滤金额为0的数据
      List<AppIndexTextListData> filter = [];
      for (AppIndexTextListData data in state.homeData.appIndexTextList.list) {
        if (data.money > 0) {
          filter.add(data);
        }
      }
      itemBeans.add(new ItemBean(GameRewardMarqueeComponent.componentName,
          game_reward_marquee.initState(filter)));
    }
    itemBeans.add(new ItemBean(GameRewardSelectComponent.componentName,
        game_reward_select.initState(null)));

    itemBeans.addAll(getSpecialGameList(HbFragmentComponent.typeName,
        state.videoType, state.homeData, state.cardPage, state.switchSelectIndex, state.indexSelectTabState));

    itemBeans.add(ItemBean(IndexEmptyBottomComponent.componentName,
        index_empty_bottom.initState(null)));
    return itemBeans;
  }

  @override
  void set(HbFragmentState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
