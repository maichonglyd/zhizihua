import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineCommonFuncAction {
  action,
  gotoMyGift,
  gotoIntegralShop,
  gotoRecharge,
  gotoDownload,
  gotoRebate,
  gotoActivityNews,
  gotoFeedback,
  gotoRegisterAgreement,
  gotoInvite,
  gotoService,
  gotoUseInstructions,
  gotoSetting,
  gotoInviteList,
  gotoCoupon,
  gotoDisclaimer,
  gotoDisputeResolution,
  gotoGameCurrencyList,
  gotoUserPrivacy,
}

class MineCommonFuncActionCreator {
  static Action onAction() {
    return const Action(MineCommonFuncAction.action);
  }

  static Action gotoRegisterAgreement() {
    return const Action(MineCommonFuncAction.gotoRegisterAgreement);
  }

  static Action gotoDisclaimer() {
    return const Action(MineCommonFuncAction.gotoDisclaimer);
  }

  static Action gotoDisputeResolution() {
    return const Action(MineCommonFuncAction.gotoDisputeResolution);
  }

  static Action gotoSetting() {
    return const Action(MineCommonFuncAction.gotoSetting);
  }

  static Action gotoInviteList() {
    return const Action(MineCommonFuncAction.gotoInviteList);
  }

  static Action gotoInvite() {
    return const Action(MineCommonFuncAction.gotoInvite);
  }

  static Action gotoService() {
    return const Action(MineCommonFuncAction.gotoService);
  }

  static Action gotoUseInstructions() {
    return const Action(MineCommonFuncAction.gotoUseInstructions);
  }

  static Action gotoFeedback() {
    return const Action(MineCommonFuncAction.gotoFeedback);
  }

  static Action gotoRebate() {
    return const Action(MineCommonFuncAction.gotoRebate);
  }

  static Action gotoActivityNews() {
    return const Action(MineCommonFuncAction.gotoActivityNews);
  }

  static Action gotoMyGift() {
    return const Action(MineCommonFuncAction.gotoMyGift);
  }

  static Action gotoCoupon() {
    return const Action(MineCommonFuncAction.gotoCoupon);
  }

  static Action gotoIntegralShop() {
    return const Action(MineCommonFuncAction.gotoIntegralShop);
  }

  static Action gotoRecharge() {
    return const Action(MineCommonFuncAction.gotoRecharge);
  }

  static Action gotoDownload() {
    return const Action(MineCommonFuncAction.gotoDownload);
  }

  static Action gotoGameCurrencyList() {
    return const Action(MineCommonFuncAction.gotoGameCurrencyList);
  }

  static Action gotoUserPrivacy() {
    return const Action(MineCommonFuncAction.gotoUserPrivacy);
  }
}
