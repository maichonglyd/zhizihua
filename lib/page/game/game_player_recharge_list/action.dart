import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/cpl_mem_rank_list.dart';

//TODO replace with your own action
enum GamePlayerRechargeListAction {
  action,
  getData,
  updateData,
}

class GamePlayerRechargeListActionCreator {
  static Action onAction() {
    return const Action(GamePlayerRechargeListAction.action);
  }

  static Action getData(int page) {
    return Action(GamePlayerRechargeListAction.getData, payload: page);
  }

  static Action updateData(List<CplMemRank> list) {
    return Action(GamePlayerRechargeListAction.updateData, payload: list);
  }
}
