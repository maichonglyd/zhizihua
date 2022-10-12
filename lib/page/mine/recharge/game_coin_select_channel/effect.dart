import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GameCoinSelectChannelState> buildEffect() {
  return combineEffects(<Object, Effect<GameCoinSelectChannelState>>{
    GameCoinSelectChannelAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<GameCoinSelectChannelState> ctx) {}

void _init(Action action, Context<GameCoinSelectChannelState> ctx) {}
