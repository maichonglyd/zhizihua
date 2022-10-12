import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/coupon/coupon_game_list.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart'
    as game_details;
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:video_player/video_player.dart';

//TODO replace with your own action
enum GameDetailsAction {
  action,
  createController,
  createPlayController,
  initPlay,
  back,
  updateGameData,
  gotoWeb,
  gotoAddQQGroup,
  gotoDownload,
  showShare,
  notifyShare,
  showMoreSer,
  updateExpand,
  init,
  err,
  getVideoData,
  updateVideoData,
  showVideoView,
  showDownDialog,
  showRechargeDialog,
  updateGames,
  gotoRecharge,
  subscribe,
  gotoPlay,
  getCouponList,
  updateCouponList,
  gotoGameComment,
}

class GameDetailsActionCreator {
  static Action onAction() {
    return const Action(GameDetailsAction.action);
  }

  static Action init() {
    return const Action(GameDetailsAction.init);
  }

  static Action err() {
    return const Action(GameDetailsAction.err);
  }

  static Action showDownDialog() {
    return Action(
      GameDetailsAction.showDownDialog,
    );
  }

  static Action showRechargeDialog() {
    return Action(
      GameDetailsAction.showRechargeDialog,
    );
  }

  static Action gotoRecharge(Game game) {
    return Action(GameDetailsAction.gotoRecharge, payload: game);
  }

  static Action updateGames(List<Game> games) {
    return Action(GameDetailsAction.updateGames, payload: games);
  }

  static Action updateExpand(bool isExpand) {
    return Action(GameDetailsAction.updateExpand, payload: isExpand);
  }

  static Action showMoreSer() {
    return const Action(GameDetailsAction.showMoreSer);
  }

  static Action showShare() {
    return const Action(GameDetailsAction.showShare);
  }

  static Action notifyShare(String type) {
    return Action(GameDetailsAction.notifyShare, payload: type);
  }

  static Action gotoDownload() {
    return const Action(GameDetailsAction.gotoDownload);
  }

  static Action gotoAddQQGroup() {
    return Action(GameDetailsAction.gotoAddQQGroup);
  }

  static Action onCreateController(
      TabController tabController, ScrollController scrollController) {
    return Action(GameDetailsAction.createController, payload: {
      "tabController": tabController,
      "scrollController": scrollController
    });
  }

  static Action onCreatePlayController(
      VideoPlayerController videoPlayerController) {
    return Action(GameDetailsAction.createPlayController,
        payload: videoPlayerController);
  }

  static Action onInitPlay() {
    return Action(GameDetailsAction.initPlay);
  }

  static Action onBack() {
    return Action(GameDetailsAction.back);
  }

  static Action updateGameData(game_details.Data gameDetail) {
    return Action(GameDetailsAction.updateGameData, payload: gameDetail);
  }

  static Action gotoWeb(String title, String url) {
    return Action(GameDetailsAction.gotoWeb,
        payload: {"title": title, "url": url});
  }

  static Action getVideoData() {
    return Action(GameDetailsAction.getVideoData);
  }

  static Action updateVideoData(List<New> news) {
    return Action(GameDetailsAction.updateVideoData, payload: news);
  }

  static Action showVideoView() {
    return Action(GameDetailsAction.showVideoView);
  }

  static Action subscribe() {
    return Action(GameDetailsAction.subscribe);
  }

  static Action gotoPlay() {
    return Action(GameDetailsAction.gotoPlay);
  }

  static Action getCouponList() {
    return const Action(GameDetailsAction.getCouponList);
  }

  static Action updateCouponList(CouponGameList list) {
    return Action(GameDetailsAction.updateCouponList, payload: list);
  }

  static Action gotoGameComment() {
    return const Action(GameDetailsAction.gotoGameComment);
  }
}
