import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_details_fragment/action.dart';
import 'package:flutter_huoshu_app/page/game/game_comment/page.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCommentHeadState> buildEffect() {
  return combineEffects(<Object, Effect<GameCommentHeadState>>{
    GameCommentHeadAction.action: _onAction,
    GameCommentHeadAction.gotoCommitComment: _gotoCommitComment,
  });
}

void _onAction(Action action, Context<GameCommentHeadState> ctx) {}

void _gotoCommitComment(Action action, Context<GameCommentHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, GameCommitCommentPage.pageName,
          arguments: ctx.state.gameId)
      .then((data) {
    ctx.dispatch(GameDetailsActionCreator.getComments());
  });
}
