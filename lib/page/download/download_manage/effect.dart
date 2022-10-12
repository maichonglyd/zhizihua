import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DownLoadManageState> buildEffect() {
  return combineEffects(<Object, Effect<DownLoadManageState>>{
    DownLoadManageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DownLoadManageState> ctx) {}
