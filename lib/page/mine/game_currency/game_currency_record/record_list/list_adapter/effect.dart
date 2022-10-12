import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<CurrRecordListState> buildEffect() {
  return combineEffects(<Object, Effect<CurrRecordListState>>{
    CouponListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CurrRecordListState> ctx) {}
