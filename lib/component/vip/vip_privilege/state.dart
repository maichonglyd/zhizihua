import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';

class VIPPrivilegeState with GlobalBaseState<VIPPrivilegeState> {
  List<Item> commonTabs = [];

  @override
  VIPPrivilegeState clone() {
    return VIPPrivilegeState()
      ..copyGlobalFrom(this)
      ..commonTabs = initCommonTabs();
  }
}

//初始化常用功能项
List<Item> initCommonTabs() {
  List<String> tabNames = [
    getText(name: 'textTag'),
    getText(name: 'textNickname'),
    getText(name: 'textSignAddition'),
    getText(name: 'textTask'),
  ];
  List<String> images = [
    'images/vip_ic_vbs.png',
    'images/vip_ic_name.png',
    'images/vip_ic_sign.png',
    'images/vip_ic_task.png',
  ];
  List<Item> tabs = [];
  tabs.clear();
  Item game;
  for (int i = 0; i < tabNames.length; i++) {
    game = Item(tabNames[i], tabNames[i], i, images[i]);
    tabs.add(game);
  }
  return tabs;
}

VIPPrivilegeState initState() {
  return VIPPrivilegeState()..commonTabs = initCommonTabs();
}
