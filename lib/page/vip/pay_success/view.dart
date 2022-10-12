import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PaySuccessState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: huoTitle(getText(name: 'textMemberPaySuccess')),
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
      body: new Container(
        margin: EdgeInsets.only(top: 70),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/vip_ic_success.png",
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                getText(name: 'textCongratulationOpenVip'),
                style:
                    TextStyle(fontSize: 17, color: AppTheme.colors.textColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 13),
              child: Text(
                getText(name: 'textMemberTips'),
                style: TextStyle(
                    fontSize: 13, color: AppTheme.colors.textSubColor2),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  child: Text(
                    getText(name: 'textOrderInfo'),
                    style: TextStyle(fontSize: 13, color: Color(0xff3584FF)),
                  ),
                  onPressed: () {
                    showToast(getText(name: 'textOrderInfo'));
                  },
                )),
            GestureDetector(
              onTap: () {
                dispatch(PaySuccessActionCreator.gotoMemberCenter());
              },
              child: Container(
                width: double.infinity,
                height: 48,
                alignment: Alignment.center,
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: AppTheme.colors.themeColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  getText(name: 'textBackToLookGift'),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ));
}
