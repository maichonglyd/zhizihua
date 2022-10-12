import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/page/game/game_pic_gallery/page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'state.dart';

Effect<GameDetailsImagesState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsImagesState>>{
    GameDetailsImagesAction.action: _onAction,
    GameDetailsImagesAction.gotoGallery: _gotoGallery,
    GameDetailsImagesAction.changeVideoVolume: _changeVideoVolume,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
    Lifecycle.deactivate: _deactivate,
  });
}

void _init(Action action, Context<GameDetailsImagesState> ctx) {
  print("_initVideo${ctx.state.news}");
  LoginControl.saveIsFirstEnter(true);
}

void _changeVideoVolume(Action action, Context<GameDetailsImagesState> ctx) {
//  showToast("${ctx.state.hasVolume}");
  if (ctx.state.videoPlayerController.value.volume == 0) {
    ctx.state.videoPlayerController.setVolume(1);
//    ctx.dispatch(GameDetailsActionCreator.updateVolume(true));
  } else {
    ctx.state.videoPlayerController.setVolume(0);
//    ctx.dispatch(GameDetailsActionCreator.updateVolume(false));
  }
}

//不可见的时候暂停播放
void _deactivate(Action action, Context<GameDetailsImagesState> ctx) {}

void _dispose(Action action, Context<GameDetailsImagesState> ctx) {
  LoginControl.saveIsFirstEnter(false);
}

void _onAction(Action action, Context<GameDetailsImagesState> ctx) {}

void _gotoGallery(Action action, Context<GameDetailsImagesState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GalleryPage.pageName, arguments: {
    'urls': ctx.state.images.map((image) => image.url).toList(),
    "initIndex": action.payload
  });
}
