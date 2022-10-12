import 'dart:async';
import 'dart:collection';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_commit/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/action.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/state.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_tip/RecycleTipUtil.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_tip/page.dart';

Effect<AccountRecycleState> buildEffect() {
  return combineEffects(<Object, Effect<AccountRecycleState>>{
    AccountRecycleAction.action: _onAction,
    AccountRecycleAction.gotoRecord: _gotoRecord,
    AccountRecycleAction.gotoCommit: _gotoCommit,
    AccountRecycleAction.getExplain: _getExplain,
    AccountRecycleAction.getRecycleList: _getRecycleList,
    AccountRecycleAction.getRecycleListMore: _getRecycleListMore,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<AccountRecycleState> ctx) {}

void _getExplain(Action action, Context<AccountRecycleState> ctx) {
  UserService.getRecycleExplain().then((data) {
    if (data.code == 200) {
      ctx.dispatch(
          AccountRecycleActionCreator.updateExplain(data.data.content));
    }
  });
}

void _getRecycleList(Action action, Context<AccountRecycleState> ctx) {
  UserService.getRecycleList(1).then((data) {
    if (data.code == 200 && data.data.list != null) {
      List<RecycleGame> recycleGameList = List();
      data.data.list.forEach((mg) {
        int containGameIndex = _listContains(recycleGameList, mg.gameid);
        if (-1 == containGameIndex) {
          List<RecycleMg> recycleMgs = List();
          recycleMgs.add(mg);
          recycleGameList.add(RecycleGame(
              mg.gameid, mg.icon, mg.gameName, mg.rate.toString(), recycleMgs));
        } else {
          recycleGameList[containGameIndex].recycleMgs.add(mg);
        }
      });
      ctx.dispatch(
          AccountRecycleActionCreator.updateRecycleList(recycleGameList));
      ctx.state.refreshHelperController.finishRefresh(success: true);
    }
  });
}

void _getRecycleListMore(Action action, Context<AccountRecycleState> ctx) {
  int page = action.payload;
  UserService.getRecycleList(page).then((data) {
    if (data.code == 200 && data.data.list != null) {
      List<RecycleGame> recycleGameList = List();
      recycleGameList.addAll(ctx.state.recycleGames);
      data.data.list.forEach((mg) {
        int containGameIndex = _listContains(recycleGameList, mg.gameid);
        if (-1 == containGameIndex) {
          List<RecycleMg> recycleMgs = List();
          recycleMgs.add(mg);
          recycleGameList.add(RecycleGame(
              mg.gameid, mg.icon, mg.gameName, mg.rate.toString(), recycleMgs));
        } else {
          recycleGameList[containGameIndex].recycleMgs.add(mg);
        }
      });
      ctx.dispatch(
          AccountRecycleActionCreator.updateRecycleList(recycleGameList));
      ctx.state.refreshHelperController
          .finishLoad(success: true, noMore: false);
    } else {
      ctx.state.refreshHelperController.finishLoad(success: true, noMore: true);
    }
  });
}

int _listContains(List<RecycleGame> gameList, int gameId) {
  for (int i = 0; i < gameList.length; i++) {
    if (gameList[i].gameId == gameId) {
      return i;
    }
  }
  return -1;
}

void _init(Action action, Context<AccountRecycleState> ctx) {
  RecycleTipUtil.showTip(ctx.context);
  ctx.dispatch(AccountRecycleActionCreator.getExplain());
  ctx.dispatch(AccountRecycleActionCreator.getRecycleList(1));
}

void _gotoCommit(Action action, Context<AccountRecycleState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountRecycleCommitPage.pageName,
          arguments: action.payload)
      .then((data) {
    //刷新界面
    ctx.dispatch(AccountRecycleActionCreator.getRecycleList(1));
  });
}

void _gotoRecord(Action action, Context<AccountRecycleState> ctx) {
  AppUtil.gotoPageByName(ctx.context, AccountRecycleRecordPage.pageName);
}
