import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexViewPagerState> buildEffect() {
  return combineEffects(<Object, Effect<IndexViewPagerState>>{
    IndexViewPagerAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IndexViewPagerState> ctx) {}
