import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';

//TODO replace with your own action
enum PropDealFilterAction {
  action,
  gotoSelectGame,
  updateGame,
  selectServer,
  showServers,
  selectSortType,
  deleteGame,
  updateGameList,
  updateSortType,
}

class PropDealFilterActionCreator {
  static Action onAction() {
    return const Action(PropDealFilterAction.action);
  }

  static Action deleteGame() {
    return const Action(PropDealFilterAction.deleteGame);
  }

  static Action selectSortType() {
    return Action(PropDealFilterAction.selectSortType);
  }

  static Action showServers() {
    return const Action(PropDealFilterAction.showServers);
  }

  static Action updateGame(PlayedGame playedGame) {
    return Action(PropDealFilterAction.updateGame, payload: playedGame);
  }

  static Action gotoSelectGame() {
    return const Action(PropDealFilterAction.gotoSelectGame);
  }

  static Action selectServer(Service server) {
    return Action(PropDealFilterAction.selectServer, payload: server);
  }

  static Action updateGameList() {
    return Action(PropDealFilterAction.updateGameList);
  }

  static Action updateSortType(int type) {
    return Action(PropDealFilterAction.updateSortType, payload: type);
  }
}
