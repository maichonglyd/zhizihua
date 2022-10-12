import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/init_info_util.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'action.dart';
import 'state.dart';

Effect<KaifuGameState> buildEffect() {
  return combineEffects(<Object, Effect<KaifuGameState>>{
    KaifuGameAction.action: _onAction,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<KaifuGameState> ctx) {}

void _init(Action action, Context<KaifuGameState> ctx) {
  InitInfoUtil.getInitInfo().then((info) {
    if (null != info && null != info.data.list && info.data.list.length > 0) {
      List<Mod> tabList = [];
      for (Mod mod in info.data.list) {
        if ('bt' == mod.type || 'rate' == mod.type || 'h5' == mod.type) {
          tabList.add(mod);
        }
      }
      ctx.dispatch(KaifuGameActionCreator.updateKfInfo(tabList));
    }
  });
}
