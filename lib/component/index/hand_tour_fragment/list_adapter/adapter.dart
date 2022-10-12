import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/at_home_required/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/component.dart';
import 'package:flutter_huoshu_app/component/game/must_play_daily/component.dart';
import 'package:flutter_huoshu_app/component/game/new_activity/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/hand_tour_fragment/state.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';
import 'package:flutter_huoshu_app/component/index/index_gamespecial/component.dart';
import 'package:flutter_huoshu_app/component/index/index_news/component.dart';
import 'package:flutter_huoshu_app/component/index/index_news/state.dart'
    as top_news_state;
import 'package:flutter_huoshu_app/component/index/index_recommend1/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
    as row_game_state;
import 'package:flutter_huoshu_app/component/index/index_select_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart'
    as select_tab_state;
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/state.dart'
    as top_tab_state;
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';

import '../../../../model/game/game_banner.dart';
import '../../../video/huo_video_manager.dart';

class HtListAdapter extends DynamicFlowAdapter<HtFragmentState> {
  HtListAdapter()
      : super(
          pool: <String, Component<Object>>{
            IndexBannerComponent.componentName: IndexBannerComponent(),
            IndexNewsComponent.componentName: IndexNewsComponent(),
            IndexTopTabComponent.componentName: IndexTopTabComponent(),
            IndexRowGameComponent.componentName: IndexRowGameComponent(),
            BTGameItemComponent.componentName: BTGameItemComponent(),
            IndexSelectTabComponent.componentName: IndexSelectTabComponent(),
            GameSpecialHeadComponent.componentName: GameSpecialHeadComponent(),
            IndexRecommendUpComponent.componentName:
                IndexRecommendUpComponent(),
            NewActivityComponent.componentName: NewActivityComponent(),
            NewGameReserveComponent.componentName: NewGameReserveComponent(),
            MustPlayDailyComponent.componentName: MustPlayDailyComponent(),
            AtHomeRequiredComponent.componentName: AtHomeRequiredComponent(),
            GameSpecialComponent.componentName: GameSpecialComponent(),
          },
          connector: _HtListConnector(),
        );
}

class _HtListConnector extends ConnOp<HtFragmentState, List<ItemBean>> {
  @override
  List<ItemBean> get(HtFragmentState state) {
    List<ItemBean> itemBeans = <ItemBean>[
//      if (state.indexBannerState.gameBannerItems.length > 0)
//        new ItemBean(IndexBannerComponent.componentName,
//            state.indexBannerState..index = state.index),
      if (state.indexNewsState.news != null &&
          state.indexNewsState.news.length > 0)
        new ItemBean(IndexNewsComponent.componentName, state.indexNewsState),
      new ItemBean(
          IndexRowGameComponent.componentName, state.indexRowGameState),
    ];
    if (state.indexBannerState.gameBannerItems.length > 0) {
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

    int i = 0;
    if (state.gameSpecialStates != null) {
      for (GameSpecialHeadState gameSpecialState in state.gameSpecialStates) {
        switch (gameSpecialState.gameSpecial.styleType) {
          case 1:
            itemBeans.add(new ItemBean(
                GameSpecialHeadComponent.componentName, gameSpecialState));
            for (Game game in state.homeData.specialList.list[i].gameList) {
              itemBeans.add(new ItemBean(
                  BTGameItemComponent.componentName,
                  BTGameItemState()
                    ..game = game
                    ..isWelfare = true));
            }
            break;
          case 2:
            itemBeans.add(new ItemBean(
                GameSpecialComponent.componentName,
                gameSpecialState
                  ..isZK = false
                  ..isWelfare = true));
            break;
          case 3:
            itemBeans.add(new ItemBean(
                MustPlayDailyComponent.componentName, gameSpecialState));
            break;
          case 4:
            itemBeans.add(new ItemBean(
                AtHomeRequiredComponent.componentName, gameSpecialState));
            break;
          case 5:
            break;
          case 6:
            if (state.homeData.specialList != null &&
                state.homeData.specialList.list.length > 0 &&
                state.homeData.specialList.list[i].gameList != null &&
                state.homeData.specialList.list[i].gameList.length > 0) {
              itemBeans.add(new ItemBean(
                  IndexRecommendUpComponent.componentName, gameSpecialState));
            }
            break;
          case 7:
            //今日首发
            itemBeans.add(new ItemBean(
                IndexRecommendUpComponent.componentName, gameSpecialState));
            break;
          case 8:
            //新游预约
            itemBeans.add(new ItemBean(
                NewGameReserveComponent.componentName,
                state.newGameReserveState
                  ..isBT = 1
                  ..topicName = state.homeData.specialList.list[i].topicName
                  ..games = state.homeData.specialList.list[i].gameList));
            break;
          case 9:
            //人气热门和最新上架做成专栏
            List<String> tabs = List();
            tabs.clear();
            List<GameListBean> gameListBeans = List();
            gameListBeans.clear();
            gameListBeans
                .addAll(state.homeData.specialList.list[i].gameListArray);
            for (GameListBean game
                in state.homeData.specialList.list[i].gameListArray) {
              tabs.add(game.title);
            }
            if (tabs.length > 0 &&
                    state.hotGameStates != null &&
                    state.hotGameStates.length > 0 ||
                state.newGameStates != null && state.newGameStates.length > 0) {
              itemBeans.add(new ItemBean(
                  IndexSelectTabComponent.componentName,
                  state.indexSelectTabState
                    ..tabs = tabs));
            }

            if (state.switchData == 0) {
              if (state.hotGameStates != null) {
                for (BTGameItemState state in state.hotGameStates) {
                  state.isWelfare = true;
                  itemBeans.add(
                      new ItemBean(BTGameItemComponent.componentName, state));
                }
              }
            } else {
              if (state.newGameStates != null) {
                for (BTGameItemState state in state.newGameStates) {
                  state.isWelfare = true;
                  itemBeans.add(
                      new ItemBean(BTGameItemComponent.componentName, state));
                }
              }
            }
            break;
          default:
            break;
        }
        i++;
      }
    }

//    if (state.newGameReserveState.games != null &&
//        state.newGameReserveState.games.length > 0) {
//      itemBeans.add(new ItemBean(NewGameReserveComponent.componentName,
//          state.newGameReserveState..isBT = 1));
//    }

    if (state.newActivityState.news != null &&
        state.newActivityState.news.length > 0) {
      itemBeans.add(new ItemBean(
          NewActivityComponent.componentName, state.newActivityState));
    }

    return itemBeans;
  }

  @override
  void set(HtFragmentState state, List<ItemBean> items) {
    for (ItemBean item in items) {
      if (IndexSelectTabComponent.componentName == item.type) {
        state.indexSelectTabState = item.data;
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
      if (IndexNewsComponent.componentName == item.type) {
        state.indexNewsState = item.data;
        continue;
      }
      if (NewActivityComponent.componentName == item.type) {
        state.newActivityState = item.data;
        continue;
      }
    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
