import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<GameDetailsGiftFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<GameDetailsGiftFragmentState>>{
    GiftListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GameDetailsGiftFragmentState> ctx) {}
