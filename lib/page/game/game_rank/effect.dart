import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/action.dart';
import 'action.dart';
import 'state.dart';

Effect<GameRankState> buildEffect() {
  return combineEffects(<Object, Effect<GameRankState>>{
    GameRankAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameRankState> ctx) {}
void _init(Action action, Context<GameRankState> ctx) {}
