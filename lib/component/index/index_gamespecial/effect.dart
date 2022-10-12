import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameSpecialHeadState> buildEffect() {
  return combineEffects(<Object, Effect<GameSpecialHeadState>>{
    GameSpecialAction.action: _onAction,
    GameSpecialAction.gotoGameDetails: _gotoGameDetails,
    GameSpecialAction.gotoSpecialList: _gotoSpecialList,
  });
}

void _onAction(Action action, Context<GameSpecialHeadState> ctx) {}

void _gotoGameDetails(Action action, Context<GameSpecialHeadState> ctx) {
//  AppUtil.gotoGameDetailOrH5Game(ctx.context,action.payload);
  Game game = action.payload;
  if (game == null) {
    showToast(getText(name: 'textGameNoExist'));
  } else {
    AppUtil.gotoGameDetail(ctx.context, action.payload);
  }
}

void _gotoSpecialList(Action action, Context<GameSpecialHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameSpecialPagePage.pageName, arguments: {
    "title": ctx.state.gameSpecial.topicName,
    "specialId": ctx.state.gameSpecial.topicId
  });
}
