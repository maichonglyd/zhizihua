import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';

import 'action.dart';

class MineFunListState with GlobalBaseState<MineFunListState> {
  List<String> icons = [
    "images/icon_n_hdzxun.png",
    "images/icon_n_application.png",
//    if(AppConfig.hasRecycle)"images/icon_n_xiaohaohuishou.png",
    if (!Platform.isIOS) "images/icon_n_Invitation.png",
    "images/icon_n_Iist.png",
    "images/icon_n_kefu.png",
    "images/icon_n_safe.png",
    "images/icon_n_mze.png",
    "images/icon_n_jfen.png",
    "images/icon_n_set.png",
  ];

  List<Action> actions = [
    MineFunListActionCreator.gotoActivityNews(),

    MineFunListActionCreator.gotoRebate(),

//    if(AppConfig.hasRecycle)MineFunListActionCreator.gotoRecycle(),
    if (!Platform.isIOS) MineFunListActionCreator.gotoInvite(),

    MineFunListActionCreator.gotoInviteList(),

    MineFunListActionCreator.gotoService(),

    MineFunListActionCreator.gotoSecurity(),

    MineFunListActionCreator.gotoDisclaimer(),

    MineFunListActionCreator.gotoDisputeResolution(),

    MineFunListActionCreator.gotoSetting()
  ];

  List<String> names = [];

  @override
  MineFunListState clone() {
    return MineFunListState()
      ..copyGlobalFrom(this)
      ..names = initNames();
  }
}

List<String> initNames() {
  List<String> names = [
    getText(name: 'textActivityNews'),
    getText(name: 'textRebate'),
//    if(AppConfig.hasRecycle)S.current.mine_fun_list_recycle,
    if (!Platform.isIOS) getText(name: 'textInvite'),
    getText(name: 'textInviteList'),
    getText(name: 'textServiceCenter'),
    getText(name: 'textSecurity'),
    getText(name: 'textDisclaimer'),
    getText(name: 'textDispute'),
    getText(name: 'textSetting'),
  ];

  return names;
}

MineFunListState initState() {
  return MineFunListState()..names = initNames();
}
