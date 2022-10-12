import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCommitCommentState> buildEffect() {
  return combineEffects(<Object, Effect<GameCommitCommentState>>{
    GameCommitCommentAction.action: _onAction,
    GameCommitCommentAction.commitComment: _commitComment,
  });
}

void _onAction(Action action, Context<GameCommitCommentState> ctx) {}
void _commitComment(Action action, Context<GameCommitCommentState> ctx) {
  GameService.commitComments(ctx.state.gameId, ctx.state.contentController.text,
          ctx.state.starNum * 2)
      .then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastCommentSuccessful'));
      Navigator.of(ctx.context).pop();
    }
  });
}
