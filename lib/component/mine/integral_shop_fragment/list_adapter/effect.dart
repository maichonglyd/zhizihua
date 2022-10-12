import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<IntegralShopFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralShopFragmentState>>{
    IntegralShopListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IntegralShopFragmentState> ctx) {}
