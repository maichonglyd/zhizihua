import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

//TODO replace with your own action
enum KaifuGameAction { action, updateKfInfo, }

class KaifuGameActionCreator {
  static Action onAction() {
    return const Action(KaifuGameAction.action);
  }

  static Action updateKfInfo(List<Mod> list) {
    return Action(KaifuGameAction.updateKfInfo, payload: list);
  }
}
