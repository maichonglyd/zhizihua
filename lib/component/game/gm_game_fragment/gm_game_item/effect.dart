import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GmGameItemState> buildEffect() {
  return combineEffects(<Object, Effect<GmGameItemState>>{
    GmGameItemAction.action: _onAction,
    GmGameItemAction.gotoGm: _gotoGm,
  });
}

void _onAction(Action action, Context<GmGameItemState> ctx) {
  AppUtil.gotoGameDetailOrH5Game(ctx.context, ctx.state.game);
}

void _gotoGm(Action action, Context<GmGameItemState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }

  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: {
    "title": ctx.state.game.gameName,
    "url": ctx.state.game.gmUrl
  });
}
