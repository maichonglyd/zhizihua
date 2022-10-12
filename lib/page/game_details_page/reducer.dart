import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/game/game_community/state.dart' as game_community;
import 'package:flutter_huoshu_app/component/game/game_details_rebate/state.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

import 'package:flutter_huoshu_app/component/game/game_details_fragment/component.dart'
    as game_details;

import 'package:flutter_huoshu_app/component/game/game_details_rebate/component.dart'
    as game_rebate;

import 'package:flutter_huoshu_app/component/index/index_row_game/state.dart'
as index_row_game;
import 'package:flutter_huoshu_app/component/game/game_detail_coupon/state.dart'
as game_coupon;

Reducer<GameDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameDetailsState>>{
      GameDetailsAction.action: _onAction,
      GameDetailsAction.createController: _createController,
      GameDetailsAction.createPlayController: _createPlayController,
      GameDetailsAction.initPlay: _initPlay,
      GameDetailsAction.updateGameData: _updateGameData,
      GameDetailsAction.updateExpand: _updateExpand,
      GameDetailsAction.updateVideoData: _updateVideoData,
      GameDetailsAction.updateGames: _updateGames,
      GameDetailsAction.err: _err,
      GameDetailsAction.updateCouponList: _updateCouponList,
    },
  );
}

GameDetailsState _createController(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  newState.tabController = action.payload['tabController'];
  newState.scrollController = action.payload['scrollController'];
  return newState;
}

GameDetailsState _updateGames(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
//  List<Game> channelGames1 = action.payload;
//  List<Game> channelGames = List();
//  for (int i = 0; i < 3; i++) {
//    channelGames.add(channelGames1[0]);
//  }
  newState.channelGames = action.payload;
  return newState;
}

GameDetailsState _onAction(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  return newState;
}

GameDetailsState _err(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  newState.loadStatus = LoadStatus.error;
  return newState;
}

GameDetailsState _updateExpand(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  newState.isExpand = action.payload;
  return newState;
}

GameDetailsState _createPlayController(GameDetailsState state, Action action) {
  print("GameDetailsState:_createPlayController");
  final GameDetailsState newState = state.clone();
  newState.videoPlayerController = action.payload;
  return newState;
}

GameDetailsState _initPlay(GameDetailsState state, Action action) {
  print("GameDetailsState:_initPlay");
  final GameDetailsState newState = state.clone();
  newState.initialized = true;
  return newState;
}

GameDetailsState _updateGameData(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  newState.gameDetail = action.payload;
  newState.gameDetailsComponentState = game_details.initState(
      newState.gameDetail.image,
      newState.news,
      newState.gameDetail.desc,
      newState.gameDetail.commentStar,
      newState.gameId,
      newState.gameDetail.isBt,
      newState.gameDetail.vipDescription,
      newState.gameDetail.news,
      newState.gameDetail.gameList.list);
  GameDetailsRebateState gameDetailsRebateState =
  game_rebate.initState(newState.gameDetail.rebateDescription);
  gameDetailsRebateState.couponGameList =
      newState.gameDetailsRebateState.couponGameList;
  gameDetailsRebateState.rowGameState = index_row_game.initState()
    ..games = newState.gameDetail.gameList.list;
  newState.gameDetailsRebateState = gameDetailsRebateState;
  newState.gameCommunityState = game_community.initState(
      newState.gameDetail.commentStar, newState.gameId);
  newState.loadStatus = LoadStatus.success;
  return newState;
}

GameDetailsState _updateVideoData(GameDetailsState state, Action action) {
  print("GameDetailsState:_initPlay");
  final GameDetailsState newState = state.clone();
  newState.news = action.payload;
  return newState;
}

GameDetailsState _updateCouponList(GameDetailsState state, Action action) {
  final GameDetailsState newState = state.clone();
  var des = "";
  if (null != newState.gameDetail &&
      null != newState.gameDetail.rebateDescription) {
    des = newState.gameDetail.rebateDescription;
  }
  GameDetailsRebateState gameDetailsRebateState = game_rebate.initState(des);
  if (null != newState.gameDetail &&
      null != newState.gameDetail.gameList &&
      newState.gameDetail.gameList.list.length > 0) {
    gameDetailsRebateState.rowGameState = index_row_game.initState()
      ..games = newState.gameDetail.gameList.list;
  }
  gameDetailsRebateState.couponGameList = action.payload;

  newState.gameDetailsRebateState = gameDetailsRebateState;
//  newState.gameDetailsRebateState.couponGameList = action.payload;
  newState.gameDetailCouponState =
      game_coupon.initState(couponGameList: action.payload);
  return newState;
}
