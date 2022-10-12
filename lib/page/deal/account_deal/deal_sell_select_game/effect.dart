import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DealSellSelectGameState> buildEffect() {
  return combineEffects(<Object, Effect<DealSellSelectGameState>>{
    DealSellSelectGameAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DealSellSelectGameState> ctx) {}
