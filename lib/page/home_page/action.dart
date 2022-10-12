import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/model/coupon/reward_bean_list.dart';
import 'package:flutter_huoshu_app/model/home_tab_vo.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';

enum HomeAction {
  onInitOK,
  updateLoadOK,
  onInitCheck,
  onInitError,
  initError,
  onChangeTab,
  changeTab,
  createController,
  updateHomeTabs,
  updateDownCount,
  updateSplash,
  clickSplash,
  onLoginInvalid,
  onNotifyUpInfo,
  showTab,
  showTabFalse,
  showAddDialog,
  gotoKaifu,
  gotoInvite,
  gotoTaskCenter,
  gotoRecycle,
  gotoShop,
  gotoLottery,
  gotoGameClass,
  changTabColor,
  showProtocol,
  showCouponDialog,
  startCountDown,
  showInitCouponDialog,
  showPopupAdDialog,
  switchToClassify,
  updateProtocolStatus,
  showDialogEvent,
}

class HomeActionCreator {
  static Action onInitCheck() {
    return Action(HomeAction.onInitCheck);
  }

  static Action onInitOK(InitInfo initInfo) {
    return Action(HomeAction.onInitOK, payload: initInfo);
  }

  static Action onInitError() {
    return Action(HomeAction.onInitError);
  }

  static Action updateLoadOK(InitInfo initInfo) {
    return Action(HomeAction.updateLoadOK, payload: initInfo);
  }

  static Action initError() {
    return Action(HomeAction.initError);
  }

  static Action changeTab(int index) {
    return Action(HomeAction.changeTab, payload: index);
  }

  static Action onChangeTab(int index) {
    return Action(HomeAction.onChangeTab, payload: index);
  }

  static Action gotoKaifu() {
    return Action(HomeAction.gotoKaifu);
  }

  static Action gotoInvite() {
    return const Action(HomeAction.gotoInvite);
  }

  static Action showTab() {
    return Action(HomeAction.showTab);
  }

  static Action showTabFalse() {
    return Action(HomeAction.showTabFalse);
  }

  //底部中间的加号点击事件要弹窗,不要显示空白页面
  static Action showDialog() {
    return Action(HomeAction.showAddDialog);
  }

  static Action updateDownCount(int count) {
    return Action(HomeAction.updateDownCount, payload: count);
  }

  static Action createController(TabController tabController) {
    return Action(HomeAction.createController, payload: tabController);
  }

  static Action updateHomeTabs(List<HomeTabVO> tabs) {
    return Action(HomeAction.updateHomeTabs, payload: tabs);
  }

  static Action onLoginInvalid(bool showToast, bool gotoLoginPage) {
    return Action(HomeAction.onLoginInvalid,
        payload: {"showToast": showToast, "gotoLoginPage": gotoLoginPage});
  }

  static Action updateSplash(bool showToast, bool gotoLoginPage) {
    return Action(HomeAction.onLoginInvalid,
        payload: {"showToast": showToast, "gotoLoginPage": gotoLoginPage});
  }

  static Action onNotifyUpInfo(UpInfo upInfo) {
    return Action(HomeAction.onNotifyUpInfo, payload: upInfo);
  }

  static Action clickSplash() {
    return Action(HomeAction.clickSplash);
  }

  static Action gotoTaskCenter() {
    return Action(HomeAction.gotoTaskCenter);
  }

  static Action gotoRecycle() {
    return Action(HomeAction.gotoRecycle);
  }

  static Action gotoShop() {
    return Action(HomeAction.gotoShop);
  }

  static Action gotoLottery() {
    return Action(HomeAction.gotoLottery);
  }

  static Action gotoGameClass() {
    return Action(HomeAction.gotoGameClass);
  }

  static Action changTabColor() {
    return Action(HomeAction.gotoGameClass);
  }

  static Action showProtocol() {
    return Action(HomeAction.showProtocol);
  }

  static Action showCouponDialog() {
    return const Action(HomeAction.showCouponDialog);
  }

  static Action startCountDown() {
    return const Action(HomeAction.startCountDown);
  }

  static Action showInitCouponDialog() {
    return const Action(HomeAction.showInitCouponDialog);
  }

  static Action showPopupAdDialog() {
    return const Action(HomeAction.showPopupAdDialog);
  }

  static Action switchToClassify(num classifyId) {
    return Action(HomeAction.switchToClassify, payload: classifyId);
  }

  static Action updateProtocolStatus(bool agree) {
    return Action(HomeAction.updateProtocolStatus, payload: agree);
  }

  static Action showDialogEvent() {
    return Action(HomeAction.showDialogEvent);
  }
}
