import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<DealShopListPageState> buildEffect() {
  return combineEffects(<Object, Effect<DealShopListPageState>>{
    DealListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DealShopListPageState> ctx) {}
