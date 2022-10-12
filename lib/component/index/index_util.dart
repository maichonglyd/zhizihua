import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/at_home_required/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/component.dart';
import 'package:flutter_huoshu_app/component/game/bt_game_item/state.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/home/state.dart';
import 'package:flutter_huoshu_app/component/game/game_simple_header/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/component.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart'
    as game_special_head;
import 'package:flutter_huoshu_app/component/game/must_play_daily/component.dart';
import 'package:flutter_huoshu_app/component/index/hb_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_gamespecial/component.dart';
import 'package:flutter_huoshu_app/component/index/index_recommend/component.dart';
import 'package:flutter_huoshu_app/component/index/index_recommend1/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/component.dart';
import 'package:flutter_huoshu_app/component/index/index_select_tab/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart' as home_bean;
import 'package:flutter_huoshu_app/utils/fragment_util.dart';
import 'package:flutter_huoshu_app/component/game/game_simple_header/component.dart';
import 'package:flutter_huoshu_app/component/game/game_simple_header/state.dart'
    as game_simple_header;
import 'package:flutter_huoshu_app/component/game/game_hot_classify/component.dart';
import 'package:flutter_huoshu_app/component/game/game_hot_classify/state.dart'
    as game_hot_classify;
import 'package:flutter_huoshu_app/component/game/game_card/component.dart';
import 'package:flutter_huoshu_app/component/game/game_card/state.dart'
    as game_card;
import 'package:flutter_huoshu_app/component/game/game_first_news/component.dart';
import 'package:flutter_huoshu_app/component/game/game_first_news/state.dart'
    as game_first_news;
import 'package:flutter_huoshu_app/component/game/game_hot_this_weekend/component.dart';
import 'package:flutter_huoshu_app/component/game/game_hot_this_weekend/state.dart'
    as game_hot_this_weekend;
import 'package:flutter_huoshu_app/component/game/game_recommend/component.dart';
import 'package:flutter_huoshu_app/component/game/game_recommend/state.dart'
    as game_recommend;
import 'package:flutter_huoshu_app/component/game/game_coming_soon/component.dart';
import 'package:flutter_huoshu_app/component/game/game_coming_soon/state.dart'
    as game_coming_soon;
import 'package:flutter_huoshu_app/component/game/game_reward_banner/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_banner/state.dart'
    as game_reward_banner;
import 'package:flutter_huoshu_app/component/game/game_reward_select/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_select/state.dart'
    as game_reward_select;
import 'package:flutter_huoshu_app/component/game/game_hot_list/component.dart';
import 'package:flutter_huoshu_app/component/game/game_hot_list/state.dart'
    as game_hot_list;
import 'package:flutter_huoshu_app/component/game/game_first_round/component.dart';
import 'package:flutter_huoshu_app/component/game/game_first_round/state.dart'
    as game_first_round;
import 'package:flutter_huoshu_app/component/game/game_new_notice/component.dart';
import 'package:flutter_huoshu_app/component/game/game_new_notice/state.dart'
    as game_new_notice;
import 'package:flutter_huoshu_app/component/game/game_quality_select/component.dart';
import 'package:flutter_huoshu_app/component/game/game_quality_select/state.dart'
    as game_quality_select;
import 'package:flutter_huoshu_app/component/game/game_reward_list/component.dart';
import 'package:flutter_huoshu_app/component/game/game_reward_list/state.dart'
    as game_reward_list;

Map<String, Component<Object>> getSpecialGameComponentPool(
    Map<String, Component<Object>> otherComponent) {
  var componentPool = <String, Component<Object>>{
    GameSimpleHeaderComponent.componentName: GameSimpleHeaderComponent(),
    GameFirstRoundComponent.componentName: GameFirstRoundComponent(),
    GameHotListComponent.componentName: GameHotListComponent(),
    GameNewNoticeComponent.componentName: GameNewNoticeComponent(),
    GameFirstNewsComponent.componentName: GameFirstNewsComponent(),
    GameHotThisWeekendComponent.componentName: GameHotThisWeekendComponent(),
    GameRecommendComponent.componentName: GameRecommendComponent(),
    GameComingSoonComponent.componentName: GameComingSoonComponent(),
    GameQualitySelectComponent.componentName: GameQualitySelectComponent(),
    GameCardComponent.componentName: GameCardComponent(),
    GameHotClassifyComponent.componentName: GameHotClassifyComponent(),
    GameRewardBannerComponent.componentName: GameRewardBannerComponent(),
    GameRewardSelectComponent.componentName: GameRewardSelectComponent(),
    GameRewardListComponent.componentName: GameRewardListComponent(),
    GameSpecialHeadComponent.componentName: GameSpecialHeadComponent(),
    BTGameItemComponent.componentName: BTGameItemComponent(),
    GameSpecialComponent.componentName: GameSpecialComponent(),
    MustPlayDailyComponent.componentName: MustPlayDailyComponent(),
    AtHomeRequiredComponent.componentName: AtHomeRequiredComponent(),
    IndexRecommendComponent.componentName: IndexRecommendComponent(),
    IndexRecommendUpComponent.componentName: IndexRecommendUpComponent(),
    NewGameReserveComponent.componentName: NewGameReserveComponent(),
    IndexSelectTabComponent.componentName: IndexSelectTabComponent(),
  };
  componentPool.addAll(otherComponent);
  return componentPool;
}

List<ItemBean> getSpecialGameList(
  String pageType,
  String pageVideoType,
  home_bean.Data homeData,
  int cardPage,
  int switchSelectIndex,
  IndexSelectTabState indexSelectTabState, {
  bool isBt = false,
  bool isZk = false,
  bool isH5 = false,
  bool isWelfare = false,
}) {
  List<ItemBean> itemBeans = [];
  if (null != homeData && null != homeData.specialList) {
    for (GameSpecial gameSpecial in homeData.specialList.list) {
      String itemVideoType = pageVideoType + "#${gameSpecial.topicId}";
      switch (gameSpecial.styleType) {
        case 1:
          if (noGameList(gameSpecial)) {
            break;
          }
          if (HbFragmentComponent.typeName == pageType) {
            itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
                game_simple_header.initState(gameSpecial)));
            itemBeans.add(new ItemBean(GameRewardListComponent.componentName,
                game_reward_list.initState(itemVideoType, gameSpecial)));
          } else {
            itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
                game_simple_header.initState(gameSpecial, showMore: true)));
            GameSpecialHeadState gameSpecialState =
                game_special_head.initState(itemVideoType);
            gameSpecialState..gameSpecial = gameSpecial;
            itemBeans.add(new ItemBean(
                GameSpecialHeadComponent.componentName, gameSpecialState));
            for (Game game in gameSpecial.gameList) {
              itemBeans.add(new ItemBean(
                  BTGameItemComponent.componentName,
                  BTGameItemState()
                    ..game = game
                    ..isZK = isZk
                    ..isWelfare = isWelfare));
            }
          }
          break;
        case 2:
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial, showMore: true)));
          GameSpecialHeadState gameSpecialState =
              game_special_head.initState(itemVideoType);
          gameSpecialState..gameSpecial = gameSpecial;
          itemBeans.add(new ItemBean(
              GameSpecialComponent.componentName,
              gameSpecialState
                ..isZK = isZk
                ..isWelfare = isWelfare));
          break;
        case 3:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial, showMore: true)));
          GameSpecialHeadState gameSpecialState = GameSpecialHeadState()
            ..gameSpecial = gameSpecial;
          itemBeans.add(new ItemBean(
              MustPlayDailyComponent.componentName, gameSpecialState));
          break;
        case 4:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial, showMore: true)));
          GameSpecialHeadState gameSpecialState = GameSpecialHeadState()
            ..gameSpecial = gameSpecial;
          itemBeans.add(new ItemBean(
              AtHomeRequiredComponent.componentName, gameSpecialState));
          break;
        case 5:
          break;
        case 6:
          GameSpecialHeadState gameSpecialState = GameSpecialHeadState()
            ..gameSpecial = gameSpecial;
          itemBeans.add(new ItemBean(
              IndexRecommendComponent.componentName, gameSpecialState));

          if (noGameList(gameSpecial)) {
            break;
          }
          for (Game game in gameSpecial.gameList) {
            itemBeans.add(new ItemBean(
                BTGameItemComponent.componentName,
                BTGameItemState()
                  ..game = game
                  ..isZK = isZk
                  ..isWelfare = isWelfare));
          }
          break;
        case 7:
          GameSpecialHeadState gameSpecialState = GameSpecialHeadState()
            ..gameSpecial = gameSpecial;
          itemBeans.add(new ItemBean(
              IndexRecommendUpComponent.componentName, gameSpecialState));
          break;
        case 8:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(
              NewGameReserveComponent.componentName,
              NewGameReserveState()
                ..isBT = (isBt ? 2 : 1)
                ..isZK = (isZk ? 2 : 1)
                ..isH5 = (isH5 ? 5 : 1)
                ..topicName = gameSpecial.topicName
                ..games = gameSpecial.gameList));
          break;
        case 9:
          if (null == indexSelectTabState) {
            break;
          }

          //人气热门和最新上架做成专栏
          itemBeans.add(ItemBean(
              IndexSelectTabComponent.componentName, indexSelectTabState));
          for (Game game
              in gameSpecial.gameListArray[switchSelectIndex].gameList) {
            itemBeans.add(ItemBean(
                BTGameItemComponent.componentName,
                BTGameItemState()
                  ..game = game
                  ..isZK = isZk
                  ..isWelfare = isWelfare));
          }
          break;
        case 11:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameFirstRoundComponent.componentName,
              game_first_round.initState(itemVideoType, gameSpecial)));
          break;
        case 12:
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameHotListComponent.componentName,
              game_hot_list.initState(null)));
          break;
        case 13:
          if (noGameList(gameSpecial)) {
            break;
          }
          FragmentConstant.setNewGameNoticeTopic(
              gameSpecial.topicId, gameSpecial.topicName);
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial, showMore: true)));
          itemBeans.add(new ItemBean(GameNewNoticeComponent.componentName,
              game_new_notice.initState(itemVideoType, pageType, gameSpecial)));
          break;
        case 14:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(
              GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial,
                  showMore: true,
                  moreButtonAction: GameSimpleHeaderState.jumpToStrategy)));
          itemBeans.add(new ItemBean(GameFirstNewsComponent.componentName,
              game_first_news.initState(gameSpecial)));
          break;

        case 15: // 本周热门
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameHotThisWeekendComponent.componentName,
              game_hot_this_weekend.initState(gameSpecial)));
          break;
        case 16:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameRecommendComponent.componentName,
              game_recommend.initState(gameSpecial)));
          break;
        case 17:
          if (noServerList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(
              GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial,
                  showMore: true,
                  moreButtonAction: GameSimpleHeaderState.jumpToKaiFu)));
          itemBeans.add(new ItemBean(GameComingSoonComponent.componentName,
              game_coming_soon.initState(gameSpecial)));
          break;
        case 18:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameQualitySelectComponent.componentName,
              game_quality_select.initState(itemVideoType, gameSpecial)));
          break;
        case 19:
          if (noGameList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameCardComponent.componentName,
              game_card.initState(pageType, cardPage, gameSpecial)));
          break;
        case 20:
          if (noCateList(gameSpecial)) {
            break;
          }
          itemBeans.add(new ItemBean(GameSimpleHeaderComponent.componentName,
              game_simple_header.initState(gameSpecial)));
          itemBeans.add(new ItemBean(GameHotClassifyComponent.componentName,
              game_hot_classify.initState(gameSpecial)));
          break;
      }
    }
  }
  return itemBeans;
}
