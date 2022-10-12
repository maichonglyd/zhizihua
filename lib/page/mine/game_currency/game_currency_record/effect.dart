import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MineCurrRecordState> buildEffect() {
  return combineEffects(<Object, Effect<MineCurrRecordState>>{
    DownLoadManageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MineCurrRecordState> ctx) {}
