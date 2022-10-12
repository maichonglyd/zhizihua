import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/model/download_sign_repository.dart';
import 'package:flutter_huoshu_app/repository/game_download_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<DownLoadGameListState> buildEffect() {
  return combineEffects(<Object, Effect<DownLoadGameListState>>{
    DownLoadGameListAction.action: _onAction,
    DownLoadGameListAction.onGetGameList: _getGameList,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<DownLoadGameListState> ctx) {}

void _getGameList(Action action, Context<DownLoadGameListState> ctx) {
  print("_getGameList");
  if (ctx.state.status == 2) {
    //已预约
    GameService.getReverseGameList(1).then((data) {
      ctx.dispatch(
          DownLoadGameListActionCreator.updateGameList(data.data.list));
    });
  } else {
    if (Platform.isAndroid) {
      DownloadTask.getAllDownloadTask().then((list) {
        list = list.where((item) => item.install == ctx.state.status).toList();
        ctx.dispatch(DownLoadGameListActionCreator.updateGameList(list));
      });
    } else {
      DownloadSignDb.getAllDownloadTaskToGameList().then((list) {
        list = list.where((item) => item.install == ctx.state.status).toList();
        ctx.dispatch(DownLoadGameListActionCreator.updateGameList(list));
      });
    }
  }
//  DownloadTask.getAllDownloadTask().then((list){
//    list=list.where((item)=>item.install==ctx.state.status).toList();
//    ctx.dispatch(DownLoadGameListActionCreator.updateGameList(list));
//  });
}

void _init(Action action, Context<DownLoadGameListState> ctx) {
  _getGameList(action, ctx);
//  DownloadTask.getAllDownloadTask().then((list){
//    list=list.where((item)=>item.install==ctx.state.status).toList();
//    ctx.dispatch(DownLoadGameListActionCreator.updateGameList(list));
//  });
}
