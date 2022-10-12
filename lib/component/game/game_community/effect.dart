import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';

import 'action.dart';
import 'state.dart';

Effect<GameCommunityState> buildEffect() {
  return combineEffects(<Object, Effect<GameCommunityState>>{
    Lifecycle.initState: _init,
    GameCommunityAction.action: _onAction,
    GameCommunityAction.getComment: _getComment,
    GameCommunityAction.clickLike: _clickLike,
  });
}

void _onAction(Action action, Context<GameCommunityState> ctx) {}

void _init(Action action, Context<GameCommunityState> ctx) {
  ctx.dispatch(GameCommunityActionCreator.getComment());
}

void _getComment(Action action, Context<GameCommunityState> ctx) {
  GameService.getComments(ctx.state.gameId).then((data) {
    ctx.dispatch(GameCommunityActionCreator.updateComment(data.data.list));
  });
}

void _clickLike(Action action, Context<GameCommunityState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName, arguments: null);
    return;
  }

  num id = action.payload['id'];
  num type = action.payload['type'];
  GameService.commentsLike(id, type).then((data) {
    ctx.dispatch(GameCommunityActionCreator.getComment());
  });
}
