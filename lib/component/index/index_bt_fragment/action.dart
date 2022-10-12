import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/model/init/init_info.dart';

//TODO replace with your own action
enum IndexBtFragmentAction {
  action,
  createController,
  gotoMessage,
  gotoSearch,
  showMenu,
  getMsgCount,
  updateMsgCount,
  updateShowMod,
  upInitInfo,
  createScrollController,
  isShowBackTop,
  updateHomeTabs,
  gotoDownload,
  upDateOffset,
}

class IndexBtFragmentActionCreator {
  static Action onAction() {
    return const Action(IndexBtFragmentAction.action);
  }

  static Action createController(TabController tabController) {
    return Action(IndexBtFragmentAction.createController,
        payload: tabController);
  }

  static Action upDateOffset(Size size, Offset offset) {
    return Action(IndexBtFragmentAction.upDateOffset,
        payload: {"size": size, "offset": offset});
  }

  static Action updateHomeTabs({int index, List<Mod> homeTabs}) {
    return Action(IndexBtFragmentAction.updateHomeTabs,
        payload: {"homeTabs": homeTabs, "index": index});
  }

  static Action createScrollController(ScrollController scrollControler) {
    return Action(IndexBtFragmentAction.createScrollController,
        payload: scrollControler);
  }

  static Action showMenu() {
    return Action(IndexBtFragmentAction.showMenu);
  }

  static Action gotoMessage() {
    return Action(IndexBtFragmentAction.gotoMessage);
  }

  static Action gotoSearch() {
    return Action(IndexBtFragmentAction.gotoSearch);
  }

  static Action gotoDownload() {
    return Action(IndexBtFragmentAction.gotoDownload);
  }

  static Action getMsgCount() {
    return Action(IndexBtFragmentAction.getMsgCount);
  }

  static Action updateMsgCount(int msgCount) {
    return Action(IndexBtFragmentAction.updateMsgCount, payload: msgCount);
  }

  static Action updateShowMod(List<String> showMod) {
    return Action(IndexBtFragmentAction.updateShowMod, payload: showMod);
  }

  static Action upInitInfo(InitInfo initInfo) {
    return Action(IndexBtFragmentAction.upInitInfo, payload: initInfo);
  }
}
