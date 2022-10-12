import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/base_icon_button.dart';

class MineCommonFuncState with GlobalBaseState<MineCommonFuncState> {
  List<BaseIconButton> commonList = [];
  List<BaseIconButton> comprehensiveList = [];

  @override
  MineCommonFuncState clone() {
    return MineCommonFuncState()
      ..copyGlobalFrom(this)
      ..commonList = commonList
      ..comprehensiveList = comprehensiveList;
  }
}

MineCommonFuncState initState() {
  return MineCommonFuncState()
    ..commonList = _initCommonList()
    ..comprehensiveList = _initComprehensiveList();
}

List<BaseIconButton> _initCommonList() {
  List<BaseIconButton> list = [];
  list.add(
      BaseIconButton(100, getText(name: 'textTaskHome'), 'images/mine_icon_task.png'));
  list.add(BaseIconButton(
      101, getText(name: 'textRecycle'), 'images/mine_icon_recovery.png'));
  list.add(BaseIconButton(
      102, getText(name: 'textRechargeRebate'), 'images/mine_icon_fl.png'));
  list.add(BaseIconButton(
      103, getText(name: 'textActivityCenter'), 'images/mine_icon_activity.png'));
  list.add(BaseIconButton(
      104, getText(name: 'textNewGameTable'), 'images/mine_icon_kaifu.png'));
//  list.add(BaseIconButton(
//      105, S.current.tab_coupon, 'images/mine_icon_daijinjuan.png'));
  list.add(BaseIconButton(106, getText(name: 'textShop'), 'images/icon_jifen.png'));
  list.add(
      BaseIconButton(107, getText(name: 'textGameCoin'), 'images/icon_youxibi.png'));
  return list;
}

List<BaseIconButton> _initComprehensiveList() {
  List<BaseIconButton> list = [];
  list.add(
      BaseIconButton(1000, getText(name: 'textMyGift'), 'images/mine_icon_gift.png'));
  list.add(BaseIconButton(
      1001, getText(name: 'textMyBill'), 'images/mine_icon_zhangdan.png'));
  list.add(BaseIconButton(
      1002, getText(name: 'textInviteList'), 'images/mine_icon_yqlb.png'));
  list.add(BaseIconButton(
      1003, getText(name: 'textOperatorGuide'), 'images/mine_icon_syzn.png'));
  list.add(
      BaseIconButton(1004, getText(name: 'textFeedback'), 'images/mine_icon_ts.png'));
  list.add(BaseIconButton(
      1005, getText(name: 'textContactService'), 'images/mine_icon_lxkf.png'));
  list.add(BaseIconButton(
      1006, getText(name: 'textPrivateProtocol'), 'images/mine_icon_ysxy.png'));
  list.add(BaseIconButton(
      1007, getText(name: 'textResponsibility'), 'images/mine_icon_mzsm.png'));
  list.add(
      BaseIconButton(1008, getText(name: 'textDispute'), 'images/mine_icon_jfcl.png'));
  return list;
}
