import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/action.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SecurityState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textSecurity')),
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
          height: 100,
          margin: EdgeInsets.all(14),
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  dispatch(SecurityActionCreator.gotoUpdateMobile());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/icon_iphone.png",
                      height: 58,
                      width: 58,
                    ),
                    Text(
                      getText(name: 'textSecretPhone'),
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  dispatch(SecurityActionCreator.gotoUpdatePassword());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/icon_password.png",
                      height: 58,
                      width: 58,
                    ),
                    Text(
                      getText(name: 'textModifyPassword'),
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: state.serviceInfo != null
              ? ListView(
                  children: state.serviceInfo.data.faq.list
                      .map((faq) => buildQwItem(faq))
                      .toList())
              : Container(),
        )

        //  buildQwItem(),
      ],
    ),
  );
}

Widget buildQwItem(Faq faq) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7))),
    margin: EdgeInsets.only(left: 14, right: 14, top: 14),
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Q：${faq.title}",
          style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
          margin: EdgeInsets.only(top: 10, bottom: 10),
        ),
        Text(
          "A：${faq.answer}",
          style: TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
        ),
      ],
    ),
  );
}
