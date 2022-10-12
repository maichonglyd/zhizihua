import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineFunListAction {
  action,
  gotoSetting,
  gotoInvite,
  gotoInviteList,
  gotoRebate,
  gotoService,
  gotoSecurity,
  gotoRecycle,
  gotoActivityNews,
  gotoDisclaimer,
  gotoDisputeResolution,
}

class MineFunListActionCreator {
  static Action onAction() {
    return const Action(MineFunListAction.action);
  }

  static Action gotoRecycle() {
    return const Action(MineFunListAction.gotoRecycle);
  }

  static Action gotoSetting() {
    return const Action(MineFunListAction.gotoSetting);
  }

  static Action gotoInvite() {
    return const Action(MineFunListAction.gotoInvite);
  }

  static Action gotoInviteList() {
    return const Action(MineFunListAction.gotoInviteList);
  }

  static Action gotoRebate() {
    return const Action(MineFunListAction.gotoRebate);
  }

  static Action gotoService() {
    return const Action(MineFunListAction.gotoService);
  }

  static Action gotoSecurity() {
    return const Action(MineFunListAction.gotoSecurity);
  }

  static Action gotoActivityNews() {
    return const Action(MineFunListAction.gotoActivityNews);
  }

  static Action gotoDisclaimer() {
    return const Action(MineFunListAction.gotoDisclaimer);
  }

  static Action gotoDisputeResolution() {
    return const Action(MineFunListAction.gotoDisputeResolution);
  }
}
