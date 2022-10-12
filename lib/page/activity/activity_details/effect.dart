import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'action.dart';
import 'state.dart';

Effect<ActivityDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<ActivityDetailsState>>{
    ActivityDetailsAction.action: _onAction,
    ActivityDetailsAction.getNewDetails: _getNewDetails,
    Lifecycle.initState: _init,
    ActivityDetailsAction.getGameListByGameName: _getGameListByGameName,
    ActivityDetailsAction.showDownDialog: _showDownDialog,
    ActivityDetailsAction.gotoGameDetails: _gotoGameDetails,
  });
}

void _onAction(Action action, Context<ActivityDetailsState> ctx) {}

void _init(Action action, Context<ActivityDetailsState> ctx) {
  ctx.dispatch(ActivityDetailsActionCreator.getNewDetails());
}

void _gotoGameDetails(Action action, Context<ActivityDetailsState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": ctx.state.newsDetailsData.data.appId});
}

void _getNewDetails(Action action, Context<ActivityDetailsState> ctx) {
  GameService.getNewDetails(ctx.state.newsId).then((data) {
    ctx.dispatch(ActivityDetailsActionCreator.updateData(data));
    ctx.dispatch(
        ActivityDetailsActionCreator.getGameListByGameName(data.data.gameName));
  });
}

void _getGameListByGameName(Action action, Context<ActivityDetailsState> ctx) {
//  GameService.getGamesByGameName(action.payload).then((data) {
//    if (data.code == 200) {
//      if (data.data.list != null&& data.data.list.length>0) {
//        ctx.dispatch(ActivityDetailsActionCreator.updateGames(data.data.list));
//      }
//    } else {
//      //更新err
//    }
//  });
}

void _showDownDialog(Action action, Context<ActivityDetailsState> ctx) {}
