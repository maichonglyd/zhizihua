import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/action.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';

Effect<GameCurrItemState> buildEffect() {
  return combineEffects(<Object, Effect<GameCurrItemState>>{
    BTGameItemAction.action: _onAction,
    BTGameItemAction.gotoGameDetails: _gotoGameDetails,
    BTGameItemAction.deleteGame: _deleteGame,
  });
}

void _gotoGameDetails(Action action, Context<GameCurrItemState> ctx) {
  Game game = action.payload;
  AppUtil.gotoPageByName(ctx.context, GameDetailsPage.pageName,
      arguments: {"gameId": game.gameId});
}

void _onAction(Action action, Context<GameCurrItemState> ctx) {
//  AppUtil.gotoGameDetailOrH5Game(ctx.context, ctx.state.game);
}

void _deleteGame(Action action, Context<GameCurrItemState> ctx) {
//  DownloadTask.deleteTaskByGame(ctx.state.game).then((data) {
//    print(data);
//    ctx.dispatch(DownLoadGameListActionCreator.onGetGameList());
//  });
//  FlutterDownloadPlugin.removeTask("${ctx.state.game.gameName}.apk",
//      ctx.state.game.downUrl, ctx.state.game.gameId);
}
