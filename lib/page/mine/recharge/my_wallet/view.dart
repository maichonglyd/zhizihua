import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyWalletState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: huoTitle(getText(name: 'textMyWallet')),
      elevation: 0,
      centerTitle: true,
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
    ),
    body: Column(
      children: <Widget>[
        Container(
          height: 227,
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("${AppConfig.ptzName}${getText(name: 'textBalancePrices')}"),
              Text(
                state.ptbCnt.toString(),
                style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 34,
                width: 105,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppTheme.colors.themeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: MaterialButton(
                  onPressed: () {
                    dispatch(MyWalletActionCreator.gotoRecharge());
                  },
                  child: Text(
                    getText(name: 'textRecharge'),
                    style: TextStyle(
                        color: AppTheme.colors.themeColor, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(MyWalletActionCreator.gotoIncomePage());
          },
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Row(
              children: <Widget>[
                Text(
                  getText(name: 'textGetHistory'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
                ),
                Expanded(child: Container()),
                Icon(Icons.arrow_forward_ios, size: 16)
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 14, right: 14),
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(MyWalletActionCreator.gotoExpensePage());
          },
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Row(
              children: <Widget>[
                Text(
                  getText(name: 'textConsumeHistory'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 14, right: 14),
          height: 1,
          color: AppTheme.colors.lineColor,
        )
      ],
    ),
  );
}
