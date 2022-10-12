import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/new_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/action.dart';
import 'package:flutter_huoshu_app/component/index/rmb_fragment/component.dart';
import 'package:flutter_huoshu_app/page/game/game_new_notice/page.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSimpleHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<GameSimpleHeaderState>>{
    GameSimpleHeaderAction.action: _onAction,
    GameSimpleHeaderAction.gotoSpecialList: _gotoSpecialList,
  });
}

void _onAction(Action action, Context<GameSimpleHeaderState> ctx) {}

void _gotoSpecialList(Action action, Context<GameSimpleHeaderState> ctx) {
  if (13 == ctx.state.gameSpecial.styleType) {
    AppUtil.gotoPageByName(ctx.context, GameNewNoticePage.pageName, arguments: {
      "title": ctx.state.gameSpecial.topicName,
      "specialId": ctx.state.gameSpecial.topicId
    }).then((value) {
      switch (LoginControl.getTabType()) {
        case NewGameFragmentComponent.typeName:
          ctx.broadcast(NewGameFragmentActionCreator.getIndexData());
          break;
        case RmbFragmentComponent.typeName:
          ctx.broadcast(RmbFragmentActionCreator.getIndexData());
          break;
      }
    });
    return;
  }
  AppUtil.gotoPageByName(ctx.context, GameSpecialPagePage.pageName, arguments: {
    "title": ctx.state.gameSpecial.topicName,
    "specialId": ctx.state.gameSpecial.topicId
  });
}
