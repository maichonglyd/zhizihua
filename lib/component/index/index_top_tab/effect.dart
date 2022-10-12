import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/page.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:flutter_huoshu_app/page/deal_page/page.dart';
import 'package:flutter_huoshu_app/page/game/game_classify/page.dart';
import 'package:flutter_huoshu_app/page/game/game_kaifu/page.dart';
import 'package:flutter_huoshu_app/page/game/game_rank/page.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/lottery_activity/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/recruitment_order/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_game/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/page.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';

Effect<IndexTopTabComponentState> buildEffect() {
  return combineEffects(<Object, Effect<IndexTopTabComponentState>>{
    IndexTopTabComponentAction.action: _onAction,
    IndexTopTabComponentAction.gotoInvite: _gotoInvite,
    IndexTopTabComponentAction.gotoRebate: _gotoRebate,
    IndexTopTabComponentAction.gotoGameClassify: _gotoGameClassify,
    IndexTopTabComponentAction.gotoGameRank: _gotoGameRank,
    IndexTopTabComponentAction.gotoRecycle: _gotoRecycle,
    IndexTopTabComponentAction.gotoVipRebate: _gotoVipRebate,
    IndexTopTabComponentAction.gotoTaskCenter: _gotoTaskCenter,
    IndexTopTabComponentAction.gotoGameReserve: _gotoGameReserve,
    IndexTopTabComponentAction.gotoDealPage: _gotoDealPage,
    IndexTopTabComponentAction.gotoActivityNews: _gotoActivityNews,
    IndexTopTabComponentAction.gotoCouponCenter: _gotoCouponCenter,
    IndexTopTabComponentAction.gotoRecruitOrder: _gotoRecruitOrder,
    IndexTopTabComponentAction.gotoTurnGame: _gotoTurnGame,
    IndexTopTabComponentAction.gotoSpecialGame: _gotoSpecialGame,
    IndexTopTabComponentAction.gotoLotteryActivity: _gotoLotteryActivity,
  });
}

void _onAction(Action action, Context<IndexTopTabComponentState> ctx) {}

void _gotoInvite(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _gotoRebate(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RebateApplyPage.pageName,
      arguments: null);
}

void _gotoGameClassify(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameClassifyPage.pageName,
      arguments: null);
}

void _gotoGameRank(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameRankPage.pageName, arguments: null);
}

void _gotoRecycle(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountRecyclePage.pageName,
          arguments: null)
      .then((result) {});
}

void _gotoVipRebate(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, VipOpenPage.pageName, arguments: null);
}

void _gotoTaskCenter(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, TaskCenterPage.pageName, arguments: null);
}

void _gotoGameReserve(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, KaifuGamePage.pageName);
}

void _gotoDealPage(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealPage.pageName,
      arguments: {"index": 0});
}

void _gotoActivityNews(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ActivityNewsPage.pageName, arguments: {
    "initIndex": 0,
  });
}

void _gotoCouponCenter(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, CouponCenterPage.pageName);
}

void _gotoRecruitOrder(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, RecruitmentOrderPage.pageName);
}

void _gotoTurnGame(Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, TurnGamePage.pageName);
}

void _gotoSpecialGame(Action action, Context<IndexTopTabComponentState> ctx) {
  IndexTopTabBean bean = action.payload;
  AppUtil.gotoPageByName(ctx.context, GameSpecialPagePage.pageName, arguments: {
    "title": bean.topicName,
    "specialId": bean.topicId,
  });
}

void _gotoLotteryActivity(
    Action action, Context<IndexTopTabComponentState> ctx) {
  AppUtil.gotoPageByName(ctx.context, LotteryActivityPage.pageName);
}
