import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_community/action.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCommentItemState> buildEffect() {
  return combineEffects(<Object, Effect<GameCommentItemState>>{
    GameCommentItemAction.action: _onAction,
    GameCommentItemAction.clickLike: _clickLike,
  });
}

void _onAction(Action action, Context<GameCommentItemState> ctx) {
}

void _clickLike(Action action, Context<GameCommentItemState> ctx) {
  num id = action.payload['id'];
  num type = action.payload['type'];
  ctx.dispatch(GameCommunityActionCreator.clickLike(id, type));
}
