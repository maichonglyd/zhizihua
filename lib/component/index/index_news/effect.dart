import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexNewsState> buildEffect() {
  return combineEffects(<Object, Effect<IndexNewsState>>{
    IndexNewsAction.action: _onAction,
    IndexNewsAction.gotoWeb: _gotoWeb,
  });
}

void _onAction(Action action, Context<IndexNewsState> ctx) {}

void _gotoWeb(Action action, Context<IndexNewsState> ctx) {
  var pageName = WebPluginPage.pageName;
  if (Platform.isAndroid) {
    pageName = WebPage.pageName;
  }
  AppUtil.gotoPageByName(ctx.context, pageName, arguments: action.payload);
}
