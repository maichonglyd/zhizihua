import 'dart:io';
import 'dart:ui';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';

class MineTopTabState with GlobalBaseState<MineTopTabState> {
  List<String> tabImages = [];
  List<String> tabNames = [];

  @override
  MineTopTabState clone() {
    return MineTopTabState()
      ..copyGlobalFrom(this)
      ..tabNames = initTabNames()
      ..tabImages = initImages();
  }
}

List<String> initTabNames() {
  List<String> tabNames = [
    getText(name: 'textGift'),
    getText(name: 'textDownload'),
    getText(name: 'textRecharge'),
    getText(name: 'textShop'),
  ];
  if (Platform.isIOS) {
    tabNames[1] = getText(name: 'textInvite');
  }
  return tabNames;
}

List<String> initImages() {
  List<String> images = [
    'images/icon_n_gift.png',
    'images/icon_n_download2.png',
    'images/icon_n_Recharge.png',
    'images/icon_n_IntegralMall.png'
  ];
  if (Platform.isIOS) {
    images[1] = "images/mine_icon_n_Invitation.png";
  }
  return images;
}

MineTopTabState initState() {
  return MineTopTabState()
    ..tabImages = initImages()
    ..tabNames = initTabNames();
}
