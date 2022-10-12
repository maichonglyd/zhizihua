import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/game/game_community/action.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';

import 'action.dart';
import 'state.dart';

Effect<GameCommentResponseState> buildEffect() {
  return combineEffects(<Object, Effect<GameCommentResponseState>>{
    Lifecycle.initState: _init,
    GameCommentResponseAction.action: _onAction,
    GameCommentResponseAction.getData: _getData,
    GameCommentResponseAction.clickLike: _clickLike,
    GameCommentResponseAction.addComment: _addComment,
  });
}

void _onAction(Action action, Context<GameCommentResponseState> ctx) {}

void _init(Action action, Context<GameCommentResponseState> ctx) {
  ctx.dispatch(GameCommentResponseActionCreator.getData(1));
}

void _getData(Action action, Context<GameCommentResponseState> ctx) {
  int page = action.payload;
  GameService.getCommentResponseList(
          ctx.state.gameId, ctx.state.comment.id, page)
      .then((data) {
    if (200 == data.code) {
      var newData = ctx.state.refreshHelperController
          .controllerRefresh(data.data.list, ctx.state.commentList, page);
      if (0 >= newData.length) {
        ctx.state.refreshHelperController.isEmpty = false;
      }
      ctx.dispatch(GameCommentResponseActionCreator.updateData(newData));
    }
  });
}

void _clickLike(Action action, Context<GameCommentResponseState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName, arguments: null);
    return;
  }

  int type = 2 == ctx.state.comment.isLike ? 1 : 2;
  GameService.commentsLike(ctx.state.comment.id, type).then((data) {
    if (200 == data.code) {
      ctx.state.comment.isLike = type;
      ctx.state.comment.likeCnt =
          ctx.state.comment.likeCnt + (2 == type ? 1 : -1);
      ctx.dispatch(GameCommentResponseActionCreator.getData(1));
      ctx.broadcast(GameCommunityActionCreator.getComment());
    }
  });
}

void _addComment(Action action, Context<GameCommentResponseState> ctx) {
  String text = ctx.state.contentController.text;
  if (null == text || text.isEmpty) {
    return;
  }

  GameService.responseComment(
          ctx.state.comment.id, text, 10)
      .then((data) {
    if (data.code == 200) {
      ctx.state.contentController.text = '';
      ctx.dispatch(GameCommentResponseActionCreator.getData(1));
      ctx.broadcast(GameCommunityActionCreator.getComment());
    }
  });
}
