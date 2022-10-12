import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<DownLoadGameListState> buildEffect() {
  return combineEffects(<Object, Effect<DownLoadGameListState>>{
    DownloadGameListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DownLoadGameListState> ctx) {}
