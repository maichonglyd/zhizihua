import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/game_details_deal_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/game_community/state.dart';
import 'package:flutter_huoshu_app/component/game/game_community/state.dart' as game_community;
import 'package:flutter_huoshu_app/component/game/game_detail_coupon/state.dart';
import 'package:flutter_huoshu_app/component/game/game_detail_coupon/state.dart'
    as game_coupon;
import 'package:flutter_huoshu_app/component/game/game_details_fragment/state.dart';
import 'package:flutter_huoshu_app/component/game/game_details_rebate/state.dart';
import 'package:flutter_huoshu_app/component/gift/game_details_gift/state.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart'
    as game_details;
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/user/share_info.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_huoshu_app/component/game/game_details_fragment/component.dart'
    as game_details_state;
import 'package:flutter_huoshu_app/component/game/game_details_rebate/component.dart'
    as game_rebate;
import 'package:flutter_huoshu_app/component/deal/account_deal/game_details_deal_fragment/component.dart'
    as game_deal;
import 'package:flutter_huoshu_app/component/gift/game_details_gift/component.dart'
    as gift_deal;

class GameDetailsState extends BaseState
    implements Cloneable<GameDetailsState> {
  ShareInfo shareInfo;
  TabController tabController;
  ScrollController scrollController;

  VideoPlayerController videoPlayerController;
  bool initialized = false; // videoPlayer 是否init
  bool isPlay = false;
  int gameId;
  game_details.Data gameDetail;
  GameDetailsComponentState gameDetailsComponentState;
  GameDetailsRebateState gameDetailsRebateState = game_rebate.initState("");
  GameDetailsDealFragmentState gameDetailsDealFragmentState;
  GameDetailsGiftFragmentState gameDetailsGiftFragmentState;
  GameDetailCouponState gameDetailCouponState =
      game_coupon.GameDetailCouponState();
  GameCommunityState gameCommunityState;
  List<New> news = List();
  bool isExpand = true;

  //平台游戏
  List<Game> channelGames;

  //是否是新游
  bool isNewGame = false;

  int activityIndex = 0;

  @override
  GameDetailsState clone() {
    return GameDetailsState()
      ..tabController = tabController
      ..videoPlayerController = videoPlayerController
      ..initialized = initialized
      ..gameId = gameId
      ..gameDetail = gameDetail
      ..gameDetailsGiftFragmentState = gameDetailsGiftFragmentState
      ..gameDetailsComponentState = gameDetailsComponentState
      ..gameDetailsRebateState = gameDetailsRebateState
      ..gameDetailsDealFragmentState = gameDetailsDealFragmentState
      ..gameDetailCouponState = gameDetailCouponState
      ..gameCommunityState = gameCommunityState
      ..scrollController = scrollController
      ..isExpand = isExpand
      ..loadStatus = loadStatus
      ..channelGames = channelGames
      ..activityIndex = activityIndex
      ..news = news;
  }
}

GameDetailsState initState(Map<String, dynamic> args) {
  return GameDetailsState()
    ..gameId = args["gameId"]
    ..gameDetailsComponentState = game_details_state.initState(
        List(), List(), "", null, args["gameId"], 0, null, null, [])
    ..gameDetailsGiftFragmentState = gift_deal.initState(args["gameId"])
    ..channelGames = List()
    ..gameDetailsDealFragmentState = game_deal.initState(args["gameId"])
    ..gameCommunityState = game_community.initState(null, args["gameId"])
    ..isNewGame = args.containsKey("isNewGame") ? true : false;
}

class GameDetailsComponentConnector extends ConnOp<GameDetailsState,
    game_details_state.GameDetailsComponentState> {
  @override
  void set(GameDetailsState state,
      game_details_state.GameDetailsComponentState subState) {
//    super.set(state, subState);
    state.gameDetailsComponentState = subState;
  }

  @override
  game_details_state.GameDetailsComponentState get(GameDetailsState state) {
    return state.gameDetailsComponentState;
  }
}

class GameRebateComponentConnector
    extends ConnOp<GameDetailsState, game_rebate.GameDetailsRebateState> {
  @override
  void set(
      GameDetailsState state, game_rebate.GameDetailsRebateState subState) {
//    super.set(state, subState);
    state.gameDetailsRebateState = subState;
  }

  @override
  game_rebate.GameDetailsRebateState get(GameDetailsState state) {
    return state.gameDetailsRebateState;
  }
}

class GameDealComponentConnector
    extends ConnOp<GameDetailsState, game_deal.GameDetailsDealFragmentState> {
  @override
  void set(
      GameDetailsState state, game_deal.GameDetailsDealFragmentState subState) {
    state.gameDetailsDealFragmentState = subState;
  }

  @override
  game_deal.GameDetailsDealFragmentState get(GameDetailsState state) {
    return state.gameDetailsDealFragmentState;
  }
}

class GameGiftComponentConnector
    extends ConnOp<GameDetailsState, gift_deal.GameDetailsGiftFragmentState> {
  @override
  void set(
      GameDetailsState state, gift_deal.GameDetailsGiftFragmentState subState) {
//    super.set(state, subState);
    state.gameDetailsGiftFragmentState = subState;
  }

  @override
  gift_deal.GameDetailsGiftFragmentState get(GameDetailsState state) {
    return state.gameDetailsGiftFragmentState;
  }
}

class GameCouponComponentConnector
    extends ConnOp<GameDetailsState, game_coupon.GameDetailCouponState> {
  @override
  void set(GameDetailsState state, game_coupon.GameDetailCouponState subState) {
//    super.set(state, subState);
    state.gameDetailCouponState = subState;
  }

  @override
  game_coupon.GameDetailCouponState get(GameDetailsState state) {
    return state.gameDetailCouponState;
  }
}

class GameCommunityComponentConnector extends ConnOp<GameDetailsState,
    game_community.GameCommunityState> {
  @override
  void set(GameDetailsState state,
      game_community.GameCommunityState subState) {
//    super.set(state, subState);
    state.gameCommunityState = subState;
  }

  @override
  game_community.GameCommunityState get(GameDetailsState state) {
    return state.gameCommunityState;
  }
}
