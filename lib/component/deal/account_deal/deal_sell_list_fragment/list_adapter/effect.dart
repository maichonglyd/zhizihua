import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<DealSellListState> buildEffect() {
  return combineEffects(<Object, Effect<DealSellListState>>{
    DealSellListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DealSellListState> ctx) {}
