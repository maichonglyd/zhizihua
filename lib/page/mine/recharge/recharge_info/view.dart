import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RechargeInfoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textRechargeDes')),
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
      elevation: 0,
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 7, right: 7),
            child: Image.asset("images/chongzhi_picture.png"),
          ),
        ),
        Container(
          height: 40,
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 15),
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: MaterialButton(
            onPressed: () {
              dispatch(RechargeInfoActionCreator.gotoRechargeInfo());
            },
            child: Text(
              getText(name: 'textGotoRecharge'),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ],
    ),
  );
}
