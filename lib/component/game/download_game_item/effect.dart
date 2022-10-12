import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/action.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';

Effect<DownloadGameItemState> buildEffect() {
  return combineEffects(<Object, Effect<DownloadGameItemState>>{
    DownloadGameItemAction.action: _onAction,
    DownloadGameItemAction.gotoGameDetails: _gotoGameDetails,
    DownloadGameItemAction.deleteGame: _deleteGame,
  });
}

void _gotoGameDetails(Action action, Context<DownloadGameItemState> ctx) {
//  AppUtil.gotoGameDetailOrH5Game(ctx.context,ctx.state.game);
  Game game = action.payload;
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": game.gameId});
}

void _onAction(Action action, Context<DownloadGameItemState> ctx) {
  AppUtil.gotoGameDetailOrH5Game(ctx.context, ctx.state.game);
}

void _deleteGame(Action action, Context<DownloadGameItemState> ctx) {
  if (Platform.isIOS) {
    DownloadSignManager.deleteDownSignTaskByAppid(ctx.state.game.gameId)
        .then((data) {
      //删除文件
      ctx.dispatch(DownLoadGameListActionCreator.onGetGameList());
    });
  } else {
    DownloadTask.deleteTaskByGame(ctx.state.game).then((data) {
      //删除文件
      ctx.dispatch(DownLoadGameListActionCreator.onGetGameList());
    });
    FlutterDownloadPlugin.removeTask("${ctx.state.game.gameName}.apk",
        ctx.state.game.downUrl, ctx.state.game.gameId);
  }
}
