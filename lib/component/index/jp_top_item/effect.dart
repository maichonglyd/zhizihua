import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';
import 'action.dart';
import 'state.dart';

Effect<JPGameItemState> buildEffect() {
  return combineEffects(<Object, Effect<JPGameItemState>>{
    JPTopItemAction.action: _onAction,
  });
}

void _onAction(Action action, Context<JPGameItemState> ctx) {}
